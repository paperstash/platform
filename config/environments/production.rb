# You can't catch me, NSA!
# PaperStash::App.middleware.use Rack::SslEnforcer
# PaperStash::API.middleware.use Rack::SslEnforcer

# TODO(mtwilliams): Allow cross-domain requests from our domain only.
PaperStash.middleware.use Rack::Cors do
  allow do
    origins "*"
    resource '*', :headers => :any,
                  :methods => %w{options head get post put patch delete link unlink}
  end
end

# Tag requests with a unique identifier.
PaperStash::App.middleware.use PaperStash::Middleware::RequestTracker
PaperStash::API.middleware.use PaperStash::Middleware::RequestTracker

# Appologize on (fatal) errors.
PaperStash::App.middleware.use PaperStash::Middleware::ErrorHandler
PaperStash::API.middleware.use PaperStash::Middleware::ErrorHandler

# Dump errors to $stderr.
PaperStash::App.middleware.use PaperStash::Middleware::ErrorLogger
PaperStash::API.middleware.use PaperStash::Middleware::ErrorLogger

# Record performance using Skylight.
 # => Sinatra (+ Tilt), Sequel, and Redis.
PaperStash::App.middleware.use Skylight.middleware
PaperStash::API.middleware.use Skylight.middleware
Skylight.start!

# Once you're here. You're here. Forever...
PaperStash::App.sessions.configure do
  domain ".#{ENV['HOST']}"
  path "/"
  expires 1.year
  secret ENV['SESSION_SECRET']
end

PaperStash::App.middleware.use PaperStash::Middleware::SessionInjector
PaperStash::API.middleware.use PaperStash::Middleware::CredentialsInjector

PaperStash.database.configure do
  Grind::Databases::Postgres.configure do
    url = URI(ENV['DATABASE_URL'])
    self.user = url.user
    self.password = url.password
    self.host = url.host
    self.port = url.port
    self.database = url.path[1..-1]
  end
end

Mail.defaults do
  delivery_method :smtp,
                  :address => ENV['SMTP_HOST'],
                  :port => ENV['SMTP_PORT'],
                  :domain => PublicSuffix.parse(ENV['HOST']).domain,
                  :user_name => ENV['SMTP_USER'],
                  :password => ENV['SMTP_PASSWORD']
end




# Report errors to Sentry.
require 'sentry-raven-without-integrations'
Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
end
