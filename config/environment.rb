require_relative 'application'

if PaperStash.env.development?
  # Synchronize STDOUT and STDERR to make debugging easier.
  STDOUT.sync = STDERR.sync = true
end

if PaperStash.env.development?
  BetterErrors.application_root = PaperStash.root
  # TODO(mtwilliams): Setup our own lil' logger.
   # BetterErrors.logger = PaperStash::Logger
end

if PaperStash.env.production?
  # Report errors to Sentry.
  require 'sentry-raven-without-integrations'
  Raven.configure do |config|
    config.dsn = PaperStash.config.sentry.dsn
  end
end

PaperStash::Database.connect!

# TODO(mtwilliams): Connect to Redis and ElasticSearch.
 # PaperStash::Redis.connect!
 # PaperStash::ElasticSearch.connect!
