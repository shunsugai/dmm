require 'dmm/base'
require 'dmm/result'

module Dmm
  class Response < Dmm::Base
    attr_reader :response

    # Delegate to a Dmm::Result
    #
    # @return [Dmm::Result]
    def result
      @result ||= Dmm::Result.new @attrs[:response][:result]
      @result
    end

    def method_missing(method, *args)
      return super unless result.respond_to? method.to_sym
      result.send(method.to_sym)
    end

    def respond_to_missing?(method, include_private = false); result.respond_to?(method.to_sym, include_private) || super; end if RUBY_VERSION >= '1.9'
    def respond_to?(method, include_private = false); result.respond_to?(method.to_sym, include_private) || super; end if RUBY_VERSION < '1.9'
  end
end