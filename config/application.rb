require 'rubygems'
require 'bundler'

Bundler.require(:default, :assets, (ENV['PAPERSTASH_ENV'] || ENV['RACK_ENV'] || 'development').to_sym)

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

# For fucks sake, Sequel.
Sequel.extension :migration
Sequel::Model.plugin :timestamps
Sequel::Model.plugin :subclasses

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'app'))
require 'app'
