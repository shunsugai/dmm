require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'bundler/setup'
require 'dmm'
require 'webmock/rspec'
require 'request_helper'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.include RequestHelper
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
