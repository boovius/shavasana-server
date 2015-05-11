puts '#' * 30
puts 'in initializer'
if Sinatra::Application.environment == :development
  require 'dotenv'
  [
    :integration
    :test
  ].each do |env|
    Dotenv.load "config/dotenv/#{env}.rb"
  end
end
