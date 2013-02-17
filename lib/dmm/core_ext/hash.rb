require 'nokogiri'

class Hash
  class << self
    def from_xml(xml)
      result = Nokogiri::XML(xml)
      { result.root.name.to_s.to_sym => xml_elem_to_hash(result.root) }
    end

    private

    def xml_elem_to_hash(node)
      return node.content.to_s unless node.element?
      return nil if node.children.nil?

      result_hash = {}

      node.children.each do |child|
        result = xml_elem_to_hash(child)

        if child.name == "text"
          return result if child.next_element.nil? && child.previous_element.nil?
        elsif result_hash[child.name.to_sym]
          if result_hash[child.name.to_sym].is_a? Object::Array
            result_hash[child.name.to_sym] << result
          else
            result_hash[child.name.to_sym] = [result_hash[child.name.to_sym]] << result
          end
        else
          result_hash[child.name.to_sym] = result
        end
      end
      result_hash
    end
  end
end