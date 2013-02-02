module Dmm
  class Base
    def self.attr_reader(*attrs)
      mod = Module.new do
        attrs.each do |attribute|
          define_method attribute do
            @attrs[attribute.to_sym]
          end
          define_method "#{attribute}?" do
            !!@attribute[attribute.to_sym]
          end
        end
      end
      const_set(:Attributes, mod)
      include mod
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    def initialize(attrs={})
      @attrs = attrs
    end
  end
end