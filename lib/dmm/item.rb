require 'dmm/base'
require 'dmm/price'
require 'dmm/iteminfo'

module Dmm
  class Item < Dmm::Base
    attr_reader :service_name, :floor_name, :category_name,
    :content_id, :product_id, :title, :URL, :affiliateURL,
    :URLsp, :affiliateURLsp, :imageURL, :date,
    :jancode, :maker_product, :isbn, :stock

    alias :url :URL
    alias :affiliate_url :affiliateURL
    alias :image_url :imageURL
    alias :url_sp :URLsp
    alias :affiliate_url_sp :affiliateURLsp

    def sampleImageURL
      @attrs[:sampleImageURL][:sample_s][:image]
    end
    alias :sample_image_url :sampleImageURL

    # @return [Dmm::Price]
    def prices
      @price ||= Dmm::Price.new(@attrs[:prices])
      @price
    end

    # @return [Dmm::Iteminfo]
    def iteminfo
      @iteminfo ||= Dmm::Iteminfo.new(@attrs[:iteminfo])
      @iteminfo
    end

    def method_missing(method)
      if iteminfo.respond_to? method.to_sym
        iteminfo.send(method.to_sym)
      elsif prices.respond_to? method.to_sym
        prices.send(method.to_sym)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false); iteminfo.respond_to?(method.to_sym) || price.respond_to?(method.to_sym) || super; end if RUBY_VERSION >= '1.9'
    def respond_to?(method, include_private = false); iteminfo.respond_to?(method.to_sym) || price.respond_to?(method.to_sym) || super; end if RUBY_VERSION < '1.9'
  end
end