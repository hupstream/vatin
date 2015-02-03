ENV['RACK_ENV'] = 'test'
require 'bundler'
Bundler.require :test

require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_filter 'vendor'
  minimum_coverage(75)
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  config.include Rack::Test::Methods
end

require_relative File.join('..', 'app')
