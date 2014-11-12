require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './config/environments'
require 'pry'

use Rack::Logger

class User < ActiveRecord::Base
end

class Activity < ActiveRecord::Base
end

before do
  puts 'in before do'
  content_type :json
  headers 'Access-Control-Allow-Origin'  => 'http://localhost:9000',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

options '/' do
  puts 'in options'
  200
end

get '/' do
  Activity.all.to_json
end

post '/' do
  puts 'in post'
  puts request.body.read
  binding.pry
  activity = Activity.find(request.body.read['activity'])
  binding.pry
  activity.value += 1
  activity.save ? activity.to_json : 405
end
