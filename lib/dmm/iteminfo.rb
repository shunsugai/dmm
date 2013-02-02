require 'dmm/base'

module Dmm
  class Iteminfo < Dmm::Base
    def method_missing(method)
      if method.to_s =~ /^(series|maker|label)$/
        return nil unless @attrs[method.to_sym]
        @attrs[method.to_sym][:name]
      elsif method.to_s =~ /^(keyword|actress|director|author)$/
        return nil unless @attrs[method.to_sym]
        to_array(method)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false); return true if method.to_s =~ /^(series|maker|label|keyword|actress|director|author)$/; end if RUBY_VERSION >= '1.9'
    def respond_to? (method, include_private = false); return true if method.to_s =~ /^(series|maker|label|keyword|actress|director|author)$/; super; end if RUBY_VERSION < '1.9'

    private

    def to_array(method)
      ret_val = @attrs[method.to_sym]
      return [ret_val[:name]] if ret_val.kind_of? Hash
      selected = ret_val.select {|hash| hash[:id] =~ /^\d+$/}
      selected.map {|hash| hash[:name]}
    end
  end
end