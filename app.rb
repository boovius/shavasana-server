require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'resque'
require './job'

use Rack::Logger

configure do
  puts 'in configure'
  redis_url = ENV["REDISCLOUD_URL"] || "redis://localhost:6379/"
  uri = URI.parse(redis_url)
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis.namespace = "resque:example"
  set :redis, redis_url
end

class User < ActiveRecord::Base
end

class Activity < ActiveRecord::Base
end

def parsed_body
  JSON.parse(request.body.read)
end

before do
  content_type :json
  headers 'Access-Control-Allow-Origin'  => 'http://localhost:9000',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

options '/' do
  200
end

get '/' do
  Activity.all.to_json
end

get '/resque' do
  puts 'in resque'
  Resque.enqueue(UpdateCounts)
end

put '/' do
  activity = Activity.find(parsed_body['activity'])
  activity.value += 1
  activity.save ? activity.to_json : 405
end

post '/' do
  Activity.create({title: parsed_body['activity'], value: 0}).to_json
end
