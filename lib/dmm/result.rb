require 'dmm/base'
require 'dmm/item'

module Dmm
  class Result < Dmm::Base
    # @return [Integer]
    def result_count
      @attrs[:result_count].to_i
    end

    # @return [Integer]
    def total_count
      @attrs[:total_count].to_i
    end

    # @return [Integer]
    def first_position
      @attrs[:first_position].to_i
    end

    # @return [Array]
    def items
      return [] unless @attrs[:items]
      item_list = @attrs[:items][:item]
      item_list = [item_list] if item_list.kind_of? Hash
      item_list.map! { |item| Dmm::Item.new(item) }
    end
  end
end