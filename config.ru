require_relative 'config/application'
require_relative 'config/environment'

use PaperStash::Middleware::RequestTracker
use PaperStash::Middleware::PerformanceReporter

if PaperStash.env.development?
  use PaperStash::Middleware::Reloader
end

if PaperStash.env.development?
  use BetterErrors::Middleware
elsif PaperStash.env.production?
  use PaperStash::Middleware::ErrorHandler
  use PaperStash::Middleware::ErrorReporter
end

# TODO(mtwilliams): Use the database (via PaperStash::Session).
use Rack::Session::Cookie, :key => 'rack.session',
                           :domain => PaperStash.config.app.sessions.domain,
                           :expire_after => PaperStash.config.app.sessions.lifetime,
                           :secret => PaperStash.config.app.sessions.secret

run PaperStash::App
