require 'sinatra'
require 'json'

get '/' do
  content_type :json
  response['Access-Control-Allow-Origin'] = 'http://localhost:9000'
  [
    {'activity' => 'yoga', 'value' => 2},
    {'activity' => 'meditation', 'value' => 5}
  ].to_json
end
