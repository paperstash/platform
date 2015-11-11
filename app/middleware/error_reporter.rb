module PaperStash
  module Middleware
    # This is based off of Raven's own Rack middleware.
    class ErrorReporter
      def initialize(app)
        @app = app
      end

      def call(env)
        Raven::Context.clear!

        begin
          response = @app.call(env)
        rescue Raven::Error
          # Don't capture Raven errors
          raise
        rescue Exception => e
          self.report(e, env)
          raise
        end

        error = env['rack.exception'] || env['sinatra.error']
        self.report(error, env) if error

        response
      end

      private
        def contextify(env)
          Raven.user_context(id: env['user.id']) if env['user.id']
          Raven.user_context(username: env['user.login']) if env['user.login']
          Raven.user_context(email: env['user.email']) if env['user.email']
          Raven.tags_context(env: PaperStash.env.to_s,
                             version: PaperStash.version,
                             server: Socket.gethostname,
                             # We want to be able to search for errors by
                             # request identifier.
                             request: env['request.id'])
          Raven.rack_context(env)
        end

        def report(exception, env, opts={})
          self.contextify(env)
          Raven.capture_type(exception, opts) do |evt|
            evt.interface :http do |intf|
              intf.from_rack(env)
            end
          end
        end
    end
  end
end
