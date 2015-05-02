verbose = $VERBOSE
$VERBOSE = false
require 'database_cleaner'

# monkey patch to silence stupid warning can't get rid of
DatabaseCleaner.instance_variable_set :@cleaners, nil

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with :truncation, {:except => [
      'public.schema_migrations'
    ]}

    DatabaseCleaner.strategy = :transaction
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

$VERBOSE = verbose
