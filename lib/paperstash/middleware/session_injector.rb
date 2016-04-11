module PaperStash
  module Middleware
    class SessionInjector
      def initialize(app)
        @app = app
      end

      def call(env)
        # TODO(mtwilliams): Parse and inject session into |env|.
        @app.call(env)
      end
    end
  end
end
