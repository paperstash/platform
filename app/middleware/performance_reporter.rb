module PaperStash
  module Middleware
    class PerformanceReporter
      def initialize(app)
        @app = app
      end

      def call(env)
        started_at = Time.now
        response = @app.call(env)
        completed_at = Time.now
        env['request.took'] = took = completed_at - started_at
        # TODO(mtwilliams): Report in our logs.
         # PaperStash.logger.context(took: took)
        response
      end
    end
  end
end
