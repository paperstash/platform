module PaperStash
  module Middleware
    class CredentialsInjector
      def initialize(app)
        @app = app
      end

      def call(env)
        # TODO(mtwilliams): Parse and inject credentials into |env|.
        @app.call(env)
      end
    end
  end
end
