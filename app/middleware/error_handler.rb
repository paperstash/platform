module PaperStash
  module Middleware
    class ErrorHandler
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue
          return apologize(env)
        end

        error = env['rack.exception'] || env['sinatra.error']
        return apologize(env) if error
      end
    end

    private
      def apologize(env)
        # TODO(mtwilliams): Use a stripped-down instance of PaperStash::App.
        ['500', {'Content-Type' => 'text/html'}, [ERB.new(File.read('app/views/500.html.erb')).run(binding)]]
      end
  end
end

