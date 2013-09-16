require 'dmm'
require 'dmm/error'
require 'dmm/api/items'
require 'faraday'
require 'faraday_middleware'
require 'faraday/response/raise_dmm_error'

module Dmm
  class Client
    include Dmm::API::Items

    ROOT_URL = 'http://affiliate-api.dmm.com'
    API_VERSION = '2.00'
    COM = 'DMM.com'
    R18 = 'DMM.co.jp'
    OPTIONS = [:api_id, :affiliate_id]

    attr_accessor *OPTIONS

    # Initialize a new Client object
    #
    # @param options [Hash]
    # @return [Dmm::Client]
    def initialize(options={})
      OPTIONS.each do |id|
        send("#{id}=", options[id])
      end
      @time = Time.now.to_s
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    private

    def request(method, path, params={})
      response = connection.send(method.to_sym, path, params) do |request|
        request.url(path, params)
      end
      response.body
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(:url => ROOT_URL) do |builder|
        builder.request  :url_encoded
        builder.adapter  :net_http
        builder.use Faraday::Response::RaiseDmmError
      end
    end

    # Returns a Hash containing API query parameters
    #
    # @param [Hash]
    # @return [Hash]
    def params(options={})
      params = {
        :api_id       => @api_id,
        :affiliate_id => @affiliate_id,
        :operation    => 'ItemList',
        :version      => API_VERSION,
        :timestamp    => @time,
        :site         => Dmm::R18,
      }
      options.each_value {|val| val.encode! 'euc-jp' if val.kind_of? String}
      params.merge!(options)
    end
  end
end