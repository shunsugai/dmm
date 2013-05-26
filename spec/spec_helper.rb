require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'bundler/setup'
require 'dmm'
require 'webmock/rspec'

RSpec.configure do |config|
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end