require 'dmm/response'
require 'dmm/core_ext/hash'
require 'dmm/core_ext/string'

module Dmm
  module API
    module Items

      # Returns a Dmm::Response object
      #
      # @param options [Hash]
      # @return [Dmm::Response]
      def item_list(options={})
        res = Hash.from_xml(get('/', params(options)))
        raise Dmm::Error, error_message(res) if res[:response][:result][:errors]
        Dmm::Response.new(res)
      end

      private

      def error_message(response)
        result     = response[:response][:result]
        message    = result[:message] || "Error"
        error_name = "\s(#{result[:errors][:error][:name]})"
        error_val  = result[:errors][:error][:value] || ""
        "#{message.camelize}: #{error_val.capitalize}#{error_name}"
      end
    end
  end
end