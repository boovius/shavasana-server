require 'rubygems'
require 'bundler'
require 'resque_scheduler/server'

environment = ENV['RACK_ENV'] || :development

Bundler.require(:default, environment)

Dotenv.load if Sinatra::Application.environment == :development

use Rack::Logger
