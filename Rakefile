require_relative 'app'
require 'sinatra/activerecord/rake'
require 'resque/tasks'
require 'resque_scheduler/tasks'
require 'pry'

task "resque:setup" do
  puts 'in resque:setup'

  ENV['RACK_ENV'] = Sinatra::Application.environment.to_s

  ENV['QUEUE'] = 'counts'

  redis_url = ENV["REDISCLOUD_URL"] || "redis://localhost:6379/"
  uri = URI.parse(redis_url)
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  set :redis, redis_url

  Resque.schedule = YAML.load_file('schedule.yml')

  Resque.before_fork do
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
  end

  Resque.after_fork do
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
  end

  require './jobs'
end

# desc "Alias for resque:work (To run workers on Heroku)"
# task "jobs:work" => "resque:work"