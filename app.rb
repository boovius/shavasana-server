require './init'
require './models'
require './login'

def parsed_body
  JSON.parse(request.body.read)
end

set :protection, :origin_whitelist => ENV['WEB_ORIGIN']

before do
  content_type :json

  response.headers["Access-Control-Allow-Origin"]  = ENV['WEB_ORIGIN']
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, HEAD, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Authorization, X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
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

get '/users' do
  access_token = request.env['HTTP_X_AUTHORIZATION']
  User.find_by(access_token: access_token).to_json
end

