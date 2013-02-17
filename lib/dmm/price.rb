require 'dmm/base'

module Dmm
  class Price < Dmm::Base
    attr_reader :price

    # Returns minimum price of item
    #
    # @return [Integer]
    def min_price
      @attrs[:price].to_i
    end

    # Returns an array of hashes with a type of delivery as key and price as value
    #
    # @return [Array<Hash>]
    def deliveries
      return [] unless @attrs[:deliveries]
      @attrs[:deliveries][:delivery]
    end

    # Returns an array containing type of delivery
    #
    # @return [Array]
    def delivery_types
      @delivery_types ||= deliveries.map { |price| price[:type] }
      @delivery_types
    end

    def method_missing(method)
      if method.to_s =~ /^price_(\w+)$/
        array = deliveries.select{ |hash| hash[:type] == $1 }
        array.first[:price].to_i unless array.empty?
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false); method.to_s =~ /^price_(\w+)$/ || super; end if RUBY_VERSION >= '1.9'
    def respond_to?(method, include_private = false); method.to_s =~ /^price_(\w+)$/ || super; end if RUBY_VERSION < '1.9'
  end
end