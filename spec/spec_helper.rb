require 'bundler/setup'

ENV['RAILS_ENV'] = 'test'

require 'rails/all'
require 'byebug'

require 'factory_bot'
require 'factory_bot_rails'
require 'rspec/rails'
require 'database_cleaner'

require 'support/dummy_app/config/environment'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'vandal'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each do |file|
  next if file.include?('support/dummy_app')
  require file
end

ActiveRecord::Migration.maintain_test_schema!
ActiveRecord::Schema.verbose = false
load 'support/dummy_app/db/schema.rb'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do |_example|
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
