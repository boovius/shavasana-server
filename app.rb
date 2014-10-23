require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'

use Rack::Logger

class User < ActiveRecord::Base
end

before do
  puts "IN BEFORE DO"
  content_type :json
  headers 'Access-Control-Allow-Origin'  => 'http://localhost:9000',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

options '/' do
  puts "IN OPTIONS"
  200
end

get '/' do
  puts "IN GET"
  [
    {'id' => 1, 'activity' => 'yoga', 'value' => 100},
    {'id' => 2, 'activity' => 'meditation', 'value' => 5}
  ].to_json
end

post '/' do
  puts "IN POST"

  puts '*' * 30
  puts request.env["rack.input"]
  puts '%' * 30
  puts request.env["rack.input"].read
  puts '^' * 30
  puts request.body
  begin
    params.merge! JSON.parse(request.env["rack.input"].read)
  rescue JSON::ParserError
    logger.error "Cannot parse request body."
  end
  puts '^' * 30
  puts params
end
