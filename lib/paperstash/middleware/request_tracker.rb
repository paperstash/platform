module PaperStash
  module Middleware
    class RequestTracker
      def initialize(app)
        @app = app
      end

      def call(env)
        @request_id = env['HTTP_X_REQUEST_ID']
        puts "request_id=#{@request_id}"
        @app.call(env)
      end
    end
  end
end
