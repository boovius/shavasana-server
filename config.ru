Bundler.require(ENV['RACK_ENV'])

require './app'
run Sinatra::Application
