set :protection, :origin_whitelist => ENV['WEB_ORIGIN']

LOGIN_PATH = /(\/login\/*|\/\z)/
ASSETS_PATH = /\/assets\/*/

def login_request
  request.env["REQUEST_PATH"] =~ LOGIN_PATH
end

def assets_request
  request.env["REQUEST_PATH"] =~ ASSETS_PATH
end

def authorize_request
  auth_token = request.env['HTTP_X_AUTHORIZATION']
  @user = User.find_by(token: auth_token)

  if @user == nil
    error = "Access Token #{auth_token} not attributal to any user"
    halt 401, {'Content-Type' => 'text/plain'}, error
  end
end

before do
  content_type :json

  response.headers["Access-Control-Allow-Origin"]  = ENV['WEB_ORIGIN']
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, HEAD, DELETE, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "X-Authorization, X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  if request.env["REQUEST_METHOD"] != "OPTIONS" &&
     !login_request &&
     !assets_request
    authorize_request
  end
end

options '*' do
  200
end
