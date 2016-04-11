source 'https://rubygems.org'

# TODO(mtwilliams): Use Rubinius.
# ruby '2.2.3', :engine => 'rbx', :engine_version => '2.5.8'

ruby '2.2.3'

gem 'dotenv'
gem 'pry'
gem 'rake'
gem 'yard', :group => [:development]
gem 'airborne', :group => [:development, :test]
gem 'mocha', :group => [:development, :test]

# I don't know how to live without these.
gem 'byebug', :group => :development
gem 'better_errors', :group => :development
gem 'binding_of_caller', :group => :development
gem 'raven', :group => [:production, :staging]
gem 'skylight', :require => ['skylight/sinatra'], :group => [:production, :staging]
# TODO(mtwilliams): Use the letter_opener gem in development.
 # gem 'letter_opener', :group => [:development]
 # gem 'letter_opener_web', :group => [:development]

# Web scale.
gem 'puma'

# Daily grind.
gem 'grind'

gem 'rack'
gem 'rack-contrib', :require => 'rack/contrib'
gem 'rack-ssl-enforcer', :require => 'rack/ssl-enforcer'
gem 'rack-cors', :require => 'rack/cors'

gem 'sinatra', :require => 'sinatra/base'
gem 'sinatra-contrib', :require => 'sinatra/contrib/all'
gem 'sinatra-subdomain', :require => 'sinatra/subdomain'

# AccessGranted for authorization.
gem 'access-granted', '~> 1.0.0'

# Erubis for HTML.
gem 'tilt'
gem 'erubis'

# Roar for JSON.
gem 'roar', :require => ['roar', 'roar/decorator', 'roar/json']
gem 'multi_json'

# Sequel as our ORM.
gem 'sequel'
# SQLite3 for simplicty.
gem 'sqlite3', :group => :development
# Postgres in the real world.
gem 'pg', :group => [:production, :staging]
# Improve row-fetching performance.
gem 'sequel_pg', :group => [:production, :staging]

# Redis for caching and work queues.
gem 'redis', :require => ['redis', 'redis/connection/hiredis'], :group => [:production, :staging]
gem 'hiredis', :group => [:production, :staging]
gem 'connection_pool', :group => [:production, :staging]

# ElasticSearch for querying goodness.
# gem 'elasticsearch-model'

gem 'workers', :group => :development
# Sidekiq for web-scale workers.
gem 'sidekiq', :group => [:production, :staging]

# The trusty ol' mail gem for email.
gem 'mail'
# TODO(mtwilliams): Use Postmark? or SendGrid?
 # gem 'postmark', :group => [:production, :staging]

# Document handling.
gem 'rmagick'
gem 'pandoc-ruby'

# Foundational and infrastructure stuffs.
gem 'public_suffix'
gem 'facter', :group => [:development, :test]
gem 'http'
