require 'dmm'
require 'dmm/response'
require 'dmm/item'
require 'dmm/error'
require 'dmm/core_ext/hash'
require 'dmm/core_ext/string'
require 'faraday'
require 'faraday_middleware'
require 'faraday/response/raise_dmm_error'

module Dmm
  class Client
    ROOT_URL = 'http://affiliate-api.dmm.com'
    API_VERSION = '2.00'
    COM = 'DMM.com'
    R18 = 'DMM.co.jp'
    OPTIONS = [:api_id, :affiliate_id]

    attr_accessor *OPTIONS

    def initialize(args)
      OPTIONS.each do |id|
        send("#{id}=", args[id])
      end
    end

    # @return [Dmm::Response]
    def item_list(options={})
      res = get('/', params(options))
      pp res      raise Dmm::Error, error_message(res) if res[:response][:result][:errors]
      Dmm::Response.new(res)
    end

    # @return [Hash]
    def get(path, params={})
      request(:get, path, params)
    end

    private

    def request(method, path, params={})
      response = connection.send(method.to_sym, path, params) do |request|
        request.url(path, params)
      end
      Hash.from_xml(response.body)
    end

    def connection
      @connection ||= Faraday.new(:url => ROOT_URL) do |builder|
        builder.request  :url_encoded
        builder.adapter  :net_http
        builder.use Faraday::Response::RaiseDmmError
      end
    end

    def params(options={})
      params = {
        :api_id       => @api_id,
        :affiliate_id => @affiliate_id,
        :operation    => 'ItemList',
        :version      => API_VERSION,
        :timestamp    => Time.now.to_s,
        :site         => 'DMM.co.jp',
      }
      options.each_value {|val| val.encode! 'euc-jp' if val.kind_of? String}
      params.merge!(options)
    end

    def error_message(response)
      result     = response[:response][:result]
      message    = result[:message] || "Error"
      error_name = "\s(#{result[:errors][:error][:name]})"
      error_val  = result[:errors][:error][:value] || ""
      "#{message.camelize}: #{error_val.capitalize}#{error_name}"
    end
  end
end