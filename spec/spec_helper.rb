require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'bundler/setup'
require 'dmm'
require 'config/config'

RSpec.configure do |config|
end