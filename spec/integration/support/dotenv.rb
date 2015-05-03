require 'dotenv'

[
  :integration
  :test
].each do |env|
  Dotenv.load "config/dotenv/#{env}.rb"
end
