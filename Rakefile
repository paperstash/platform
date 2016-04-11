#!/usr/bin/env rake

require_relative 'config/application'
require_relative 'config/environment'

# TODO(mtwilliams): Move this into a tasks folder.
namespace :db do
  task :create do
    raise "Not implemented, yet."
  end

  task :drop do
    raise "Not implemented, yet."
  end

  task :migrate do
    puts "Migrating..."
    puts "===> Connecting..."
    PaperStash.database.connect!
    puts "===> Running migrations..."
    migrations = File.join(PaperStash.root, 'db', 'migrations')
    Sequel::IntegerMigrator.run(PaperStash.database.connection, migrations)
    PaperStash.database.disconnect!
    puts "Done!"
  end

  task :seed do
    puts "Seeding..."
    puts "===> Connecting..."
    PaperStash.database.connect!
    seeds = File.join(PaperStash.root, 'db', 'seed.rb')
    puts "===> Running #{seeds}"
    Kernel.load(seeds)
    PaperStash.database.disconnect!
    puts "Done!"
  end

  task :setup => ['db:migrate', 'db:seed']
end
