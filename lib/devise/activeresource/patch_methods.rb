module Devise
  module Activeresource
    module PatchMethods
      def initialize(*)
        super
        return unless self.class.schema

        keys = self.class.schema.select { |_k, v| v == 'timestamp' }.keys
        keys.each do |k|
          value = send(k.to_sym)
          next unless value.is_a?(String)

          send("#{k}=".to_sym, Time.parse(value))
        end
      end

      def invalid?
        !valid?
      end

      def assign_attributes(attributes = {})
        unless attributes.respond_to?(:to_hash)
          raise ArgumentError, 'expected attributes to be able to convert'\
            " to Hash, got #{attributes.inspect}"
        end

        attributes = attributes.to_hash
        attributes.each do |key, value|
          send("#{key}=".to_sym, value)
        end
      end

      def [](attribute_name)
        if attributes.include?(attribute_name)
          attributes[attribute_name]
        elsif respond_to?(attribute_name)
          send(attribute_name)
        else
          super
        end
      end
    end
  end
end
