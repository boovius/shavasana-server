require './init'

class User < ActiveRecord::Base
  has_many :activities
end

class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :doings
end

class Doing < ActiveRecord::Base
  belongs_to :activity

  after_save :update_counts

  def update_counts
    beginning_of_week  = Time.now - (Time.now.wday - 1).days
    beginning_of_month = Time.now - (Time.now.day - 1).days

    activity.weekly  = activity
                        .doings
                        .where('created_at > ?', beginning_of_week)
                        .count

    activity.monthly = activity
                        .doings
                        .where('created_at > ?', beginning_of_month)
                        .count

    activity.done_last_at = activity.doings.last.created_at

    activity.save
  end
end

def parsed_body
  JSON.parse(request.body.read)
end

before do
  content_type :json
  headers 'Access-Control-Allow-Origin'  => ENV['WEB_ORIGIN'],
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

options '*' do
  200
end

get '/activities' do
  Activity.all.to_json.camelize
end

post '/activities' do
  Activity.create(
    {
      title: parsed_body['activity'],
      weekly: 0,
      monthly: 0}
  ).to_json.camelize
end

post '/doings' do
  activity = Activity.find(parsed_body['activity'])
  Doing.create(activity: activity)
  activity.reload.to_json.camelize
end


