require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'resque'
require 'resque_scheduler'
require 'resque_scheduler/server'

use Rack::Logger

class User < ActiveRecord::Base
  has_many :activities
end

class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :doings
end

class Doing < ActiveRecord::Base
  belongs_to :activity
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

put '/' do
  activity = Activity.find(parsed_body['activity'])
  Doing.create(activity: activity)
  activity.done_last_at = Time.now
  activity.save ? activity.to_json : 405
end

post '/' do
  Activity.create({title: parsed_body['activity'], weekly: 0, monthly: 0}).to_json
end
