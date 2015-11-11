require_relative 'application'
require_relative 'environment'

rackup      DefaultRackup

environment PaperStash.env.to_s
bind        'tcp://0.0.0.0:80'
port        80
workers     PaperStash.config.app.workers
threads     PaperStash.config.app.threads.min,
            PaperStash.config.app.threads.max

preload_app!

before_fork do
  if PaperStash.env.production?
    # TODO(mtwilliams): Precompile assets.
  end

  # Kill our service connections before forking to prevent leakage.
  PaperStash::Database.disconnect!
end

on_worker_boot do
  # Establish our service connections per-worker.
  PaperStash::Database.connect!
end

# TODO(mtwilliams): Report low-level errors in production.
 # lowlevel_error_handler do |e|
 #   ...
 # end
