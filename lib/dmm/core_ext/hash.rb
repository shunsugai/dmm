require 'rexml/document'

class Hash
  class << self
    def from_xml(xml)
      xml_to_hash REXML::Document.new(xml).root
    end

    private

    def xml_to_hash(node)
      return { node.name.to_sym => node.text } unless node.has_elements?
      child = {}
      node.each_element do |e|
        child.merge!(xml_to_hash(e)) do |key, old_val, new_val|
          old_val.kind_of?(Array) ? old_val << new_val : [old_val, new_val]
        end
      end
      { node.name.to_sym => child }
    end
  end
end