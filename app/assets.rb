module PaperStash
  module Assets
    def self.environment
      @assets ||= begin
        assets = Sprockets::Environment.new(PaperStash.root)

        assets.append_path('assets/fonts')
        assets.append_path('assets/images')
        assets.append_path('assets/styles')
        assets.append_path('assets/scripts')

        if PaperStash.env.production?
          assets.css_compressor = CSSminify.new
          assets.js_compressor = Uglifier.new
        end

        assets
      end
    end

    def self.procompile
      # TODO(mtwilliams): Precompile assets before running in production.
       # https://checkthis.com/biye
      false
    end
  end
end
