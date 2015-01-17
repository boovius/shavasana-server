environment = ENV['RACK_ENV'] || :development

Bundler.require(:default, environment)

require './app'
run Sinatra::Application

run Rack::URLMap.new \
  "/"       => Sinatra::Application,
  "/resque" => Resque::Server.new
