require 'rubygems'
require 'bundler'
require 'resque_scheduler/server'

environment = ENV['RACK_ENV'] || :development

Bundler.require(:default, environment)

require_relative 'config/initializers/dotenv'

use Rack::Logger
