require 'sinatra/activerecord/rake'
require './app'
require 'resque/tasks'

task "resque:setup" do
  puts 'in resque:setup'
  ENV['QUEUE'] = 'counts'
  # require 'resque-scheduler'

  # Resque.schedule = YAML.load_file('schedule.yml')

  # Resque.before_fork do
  #   defined?(ActiveRecord::Base) and
  #       ActiveRecord::Base.connection.disconnect!
  # end

  # Resque.after_fork do
  #   defined?(ActiveRecord::Base) and
  #       ActiveRecord::Base.establish_connection
  # end
end

# desc "Alias for resque:work (To run workers on Heroku)"
# task "jobs:work" => "resque:work"
