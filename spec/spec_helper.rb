ENV['SHAVASANA_ENV'] = 'test'

require_relative '../app'

Dir['spec/support/**/*.rb'].each do |file|
  require_relative File.join('..', file)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.warnings = true

  config.order = :random

  Kernel.srand config.seed
  ActiveRecord::Base.logger.level = Logger::INFO
end
