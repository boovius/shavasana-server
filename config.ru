ENV['RACK_ENV'] ||= Sinatra::Application.environment.to_s

Bundler.require(ENV['RACK_ENV'])

require './app'
run Sinatra::Application

run Rack::URLMap.new \
  "/"       => Sinatra::Application,
  "/resque" => Resque::Server.new
