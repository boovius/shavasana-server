require './init'
require './models'
require './auth'
require './login'

def parsed_body
  JSON.parse(request.body.read)
end

get '/activities' do
  @user.activities.all.to_json.camelize
end

post '/activities' do
  Activity.create(
    {
      title: parsed_body['activity'],
      weekly: 0,
      monthly: 0,
      user: @user}
  ).to_json.camelize
end

post '/doings' do
  activity = Activity.find(parsed_body['activity'])
  Doing.create(activity: activity)
  activity.reload.to_json.camelize
end

get '/users' do
  access_token = request.env['HTTP_X_AUTHORIZATION']
  User.find_by(token: access_token).to_json
end

