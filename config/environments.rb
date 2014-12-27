configure :development, :test do
  database = YAML::load(File.open('config/database.yml'))

  ActiveRecord::Base.establish_connection(database['development'])
end

