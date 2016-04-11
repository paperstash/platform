class PaperStash
  module Mail
    module Template
      ENGINES = {:html => :erb, :txt => :erb}.freeze

      def self.path(type, template)
        "#{PaperStash.root}/app/paperstash/mailers/templates/#{template}.#{type}.#{ENGINES[type]}"
      end

      def self.exists?(type, template)
        File.exist?(Template.path(type, template))
      end

      class Bindings
        def initialize(bindings={})
          @bindings = bindings
        end

        def get_binding
          binding
        end

        private
          def respond_to_missing(method_name, _include_private=false)
            @bindings.include? method_name
          end

          def method_missing(method_name, *_args)
            @bindings[method_name]
          end
      end

      def self.render(type, template, bindings)
        case ENGINES[type]
          when :erb
            fail unless self.exists?(type, template)
            # OPTIMIZE(mtwilliams): Cache in production?
            template = ERB.new(File.read(self.path(type, template)))
            bindings = Bindings.new(bindings).get_binding
            template.result(bindings)
          else
            fail
          end
      end
    end
  end

  module Mail
    def self.correct?(mail)
      return false unless mail.include? :to
      return false unless mail[:to].include? :address
      return false unless mail.include? :from
      return false unless mail[:from].include? :address
      return false unless mail.include? :subject
      return false unless mail.include? :template
      return false unless Template::ENGINES.keys.map{|type| Template.exists?(type, mail[:template])}.any?

      true
    end
  end

  class Mailer
    def mail(mail = {})
      fail unless Mail.correct?(mail)

      Mail.new do
        message_id "<#{SecureRandom.uuid}@#{ENV['HOST']}>"

        # TODO(mtwilliams): Refactor out servcice-specific headers.
        headers 'X-MC-Tags' => mail[:template].to_s,
                'X-MC-Metadata' => %{\{"template":"#{mail[:template]}"\}},
                'X-MC-Important' => mail.fetch(:important, false),
                'X-PM-Tag' => mail[:template].to_s,
                'X-PM-KeepID' => true

        if mail[:to][:name]
          to "#{mail[:to][:name]} <#{mail[:to][:address]}>"
        else
          to mail[:to][:address]
        end
        if mail[:from][:name]
          from "#{mail[:from][:name]} <#{mail[:from][:address]}>"
        else
          from mail[:from][:address]
        end

        subject mail[:subject]

        text_part do
          body Template.render(:txt, mail[:template], mail[:bindings])
        end

        html_part do
          body Template.render(:html, mail[:template], mail[:bindings])
        end
      end
    end
  end
end
