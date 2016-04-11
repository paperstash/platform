module PaperStash
  module Middleware
    class ErrorHandler
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue Exception => error
          return apologize(env, error)
        end

        error = env['rack.exception'] || env['sinatra.error']
        return apologize(env, error) if error

        response
      end

    private
      def apologize(env, _error)
        ['500', {'Content-Type' => 'text/plain'}, ["Something went terribly wrong. If the problem persists, please mention `#{env['HTTP_X_REQUEST_ID']}` to our team."]]
      end
    end
  end
end
