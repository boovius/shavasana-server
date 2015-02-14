require "net/http"
require "net/https"
require "cgi"

require "json"

use Rack::Session::Cookie, :key => 'rack.session',
                           :domain => 'foo.com',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => ENV['SESSION_SECRET']

WEB_ORIGIN = ENV['WEB_ORIGIN']
SERVER_ORIGIN = ENV['SERVER_ORIGIN']

before do
  @client_id = ENV['FACEBOOK_APP_ID']
  @client_secret = ENV['FACEBOOK_APP_SECRET']

  session[:oauth] ||= {}
end

get "/login" do
  content_type :html
  if session[:oauth][:access_token].nil?
    erb :start
  else
    if User.find_by(access_token: session[:oauth][:access_token])
      redirect "#{WEB_ORIGIN}/#/login?token=#{session[:oauth][:access_token]}"
    end
  end
end

get "/login/request" do
  binding.pry
  redirect "https://graph.facebook.com/oauth/authorize?client_id=#{@client_id}&redirect_uri=#{SERVER_ORIGIN}/login/callback"
end

get "/login/callback" do
  session[:oauth][:code] = params[:code]
  access_token = ''

  uri = URI("https://graph.facebook.com/oauth/access_token?client_id=#{@client_id}&redirect_uri=#{SERVER_ORIGIN}/login/callback&client_secret=#{@client_secret}&code=#{session[:oauth][:code]}")
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri
    response = http.request request
    access_token = CGI.parse(response.body)["access_token"][0]
  end

  if !User.find_by(access_token: access_token)
    uri = URI("https://graph.facebook.com/me?access_token=#{access_token}")
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
      data = JSON.parse(response.body)

      User.create(
        access_token: access_token,
        first_name: data['first_name'],
        last_name: data['last_name'],
        gender: data['gender'],
        fb_id: data['id']
      )
    end
  end

  session[:oauth][:access_token] = access_token
  redirect "#{WEB_ORIGIN}/#/login?token=#{access_token}"
end
