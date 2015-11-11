module PaperStash
  module Middleware
    class RequestTracker
      def initialize(app)
        @app = app
      end

      def call(env)
        # TODO(mtwilliams): Allow pass-through from/to other services.
         # See https://brandur.org/request-ids.
        env['request.id'] = SecureRandom.uuid

        env['server'] = Socket.gethostname
        env['server.env'] = PaperStash.env.to_s
        env['server.version'] = PaperStash.version

        @app.call(env)
      end
    end
  end
end
