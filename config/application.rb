require 'rubygems'
require 'bundler'

unless ENV['DOCKER'].nil?
  begin
    require 'dotenv'
    $stdout.puts "Loading environment from `.env` if available..."
    Dotenv.load! File.join(File.dirname(__FILE__), '..', '.env')
    $stdout.puts " => Loaded from `.env`."
  rescue LoadError => _
    $stderr.puts "The 'dotenv' Gem is not available on this system!"
    if File.exist?(File.join(File.dirname(__FILE__), '..', '.env'))
      $stderr.puts " => Skipping `.env` file."
    end
  rescue Errno::ENOENT
    $stderr.puts " => No `.env` file."
    false
  end
end

Bundler.require(:default)
env = (ENV['PAPERSTASH_ENV'] || ENV['RACK_ENV'] || 'development').to_sym
Bundler.require(env)

# Smells like Rails...
require 'active_support'
require 'active_support/core_ext'

# Some things aren't nicely cut gems, unforunately.
require 'base64'
require 'erb'
require 'ostruct'
require 'securerandom'
require 'socket'
require 'time'
require 'uri'
require 'yaml'

# Sometimes you just have to monkey-patch.
require_relative 'patches'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'app'))

require 'paperstash'

$stdout.puts "PaperStash setup for `#{env}`."
