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
          # Don't capture Raven errors.
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
        Raven.user_context(id: env['session'].owner.id, email: env['session'].owner.email) if env['session']
        Raven.user_context(id: env['credentials'].user.id, email: env['credentials'].user.email) if env['credentials']
        Raven.tags_context(client: env['credentials'].client) if env['credentials']
        Raven.tags_context(env: PaperStash.env.to_s,
                           version: PaperStash.version,
                           server: Socket.gethostname,
                           # We want to be able to search for errors by request identifier.
                           request: env['HTTP_X_REQUEST_ID'])
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
