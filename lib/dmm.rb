require "dmm/client"
require "dmm/version"

module Dmm
  class << self
    def new(options={})
      Dmm::Client.new(options)
    end

    def const_missing(name)
      return super unless Dmm::Client.const_defined?(name.to_sym)
      Dmm::Client.const_get(name.to_sym)
    end

    def const_defined?(name)
      Dmm::Client.const_defined?(name.to_sym) || super
    end
  end
end