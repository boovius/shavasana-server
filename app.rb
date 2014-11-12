require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'

use Rack::Logger

class User < ActiveRecord::Base
end

before do
  content_type :json
  headers 'Access-Control-Allow-Origin'  => 'http://localhost:9000',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

options '/' do
  200
end

get '/' do
  [
    {'id' => 1, 'activity' => 'yoga', 'value' => 100},
    {'id' => 2, 'activity' => 'meditation', 'value' => 5}
  ].to_json
end

post '/' do
  activity = Activity.find(request.body.read['activity'])
  activity.value += 1
  activity.save ? activity.to_json : 405
end
