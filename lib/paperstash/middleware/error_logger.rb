module PaperStash
  module Middleware
    class ErrorLogger
      def initialize(app)
        @app = app
      end

      def call(env)
        begin
          response = @app.call(env)
        rescue Exception => e
          self.log(e, env)
          raise
        end

        error = env['rack.exception'] || env['sinatra.error']
        self.log(error, env) if error

        response
      end

      def log(exception, env, opts={})
        $stderr.puts exception.to_s
        $stderr.puts exception.backtrace.join("\n") if exception.is_a? Exception
      end
    end
  end
end
