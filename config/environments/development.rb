# Synchronize STDOUT and STDERR to make debugging easier.
STDOUT.sync = STDERR.sync = true

# HACK(mtwilliams): Use a single BetterError::Middleware instance.
# Refer to https://github.com/charliesome/better_errors/issues/301#issuecomment-160739421
class BetterErrors::Middleware::Proxy
  @@middleware = BetterErrors::Middleware.new(proc {|env| @@app.call(env)})
  def initialize(app); @@app = app; end
  def call(env); @@middleware.call(env); end
end

# Things are going to break. When they do, this will make debugging much less painful.
BetterErrors.application_root = PaperStash.root
PaperStash::App.middleware.use BetterErrors::Middleware::Proxy
PaperStash::API.middleware.use BetterErrors::Middleware::Proxy

# Allow all cross-domain requests.
PaperStash::API.middleware.use Rack::Cors do
  allow do
    origins "*"
    resource '*', :headers => :any,
                  :methods => %w{options head get post put patch delete link unlink}
  end
end

PaperStash::Sessions.configure do
  domain ".localhost.dev"
  path "/"

  # Expire sessions quickly to catch otherwise missed bugs.
  expires 60.minutes.to_i

  # Force sessions to expire during different development instances so
  # transient state doesn't cause weird bugs.
  secret SecureRandom.hex(32)
end

PaperStash::Middleware.use PaperStash::SessionInjector

PaperStash::Database.configure do
  # For similar reasons, use a fresh database during different development
  # instances as well.
  Grind::Databases::SQLite3.configure do
    self.path = "db/development.sqlite3"
  end
end

Mail.defaults do
  require 'paperstash/mail_logger'
  delivery_method PaperStash::MailLogger
end
