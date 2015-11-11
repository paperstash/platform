module PaperStash
  module Middleware
    class Reloader
      def initialize(app)
        @app = app
      end

      def call(env)
        # TODO(mtwilliams): Reload on new requests (only in development).
        @app.call(env)
      end
    end
  end
end
