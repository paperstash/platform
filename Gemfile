source 'https://rubygems.org'
ruby '2.2.3'
  # ^ :engine => 'rbx', :engine_version => '2.5.8'

gem 'pry'
gem 'rake'

gem 'activesupport'
gem 'recursive-open-struct'

gem 'puma'
gem 'rack'

gem 'sinatra', :require => 'sinatra/base'
# gem 'sinatra-partial'
# gem 'sinatra-contrib', :require => 'sinatra/contrib'

gem 'tilt'
gem 'erubis'
# TODO(mtwilliams): Use Slim.
 # gem 'slim'

gem 'sequel'
# Improve row-fetching performance.
gem 'sequel_pg', :require => 'sequel'
gem 'pg'

gem 'mail'

group :assets do
  gem 'sprockets'

  gem 'sass'
  gem 'cssminify'

  gem 'coffee-script'
  gem 'execjs'
  gem 'therubyracer'
  gem 'libv8'
  gem 'uglifier'
end

group :development do
  gem 'dotenv'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'raven'
end

group :docs do
  gem 'yard'
end

group :test do
  gem 'airborne'
  gem 'mocha'
end
