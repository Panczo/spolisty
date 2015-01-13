ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/webkit/matchers'
require 'capybara-screenshot/rspec'
require 'vcr'
require 'webmock/rspec'

Capybara.javascript_driver = :webkit
require 'simplecov'
SimpleCov.start


if ENV['coverage'] == "on"
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

Dir[Rails.root.join("app/models/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("app/controllers/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.include RSpec::Rails::RequestExampleGroup, type: :request
  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
  config.raise_errors_for_deprecations!
end


VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
  WebMock.allow_net_connect!
  c.debug_logger = File.open(ARGV.first, 'w')
end
