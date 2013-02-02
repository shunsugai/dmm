require 'dmm/base'

module Dmm
  class Price < Dmm::Base
    attr_reader :price

    # @return [Integer]
    def min_price
      @attrs[:price].to_i
    end

    # @return [Array]
    def deliveries
      return [] unless @attrs[:deliveries]
      @attrs[:deliveries][:delivery]
    end

    # @return [Array]
    def delivery_types
      @delivery_types ||= deliveries.map { |price| price[:type] }
      @delivery_types
    end

    # ex) item.price_stream #=> 1980
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