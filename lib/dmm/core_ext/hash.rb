require 'nokogiri'

class Hash
  class << self
    def from_xml(xml)
      result = Nokogiri::XML(xml)
      return { result.root.name.to_s.to_sym => xml_elem_node_to_hash(result.root) }
      # xml_elem_node_to_hash(result.root)
    end

    private

    def xml_elem_node_to_hash(node)
      if node.element?
        if !node.children.nil?
          result_hash = {}

          node.children.each do |child|
            result = xml_elem_node_to_hash(child)

            if child.name == "text"
              if child.next_element.nil? && child.previous_element.nil?
                return result
              end
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
          return result_hash
        elsif !node.attributes.nil?
          #TODO
        else
          return nil
        end
      else
        return node.content.to_s
      end
    end
  end
end