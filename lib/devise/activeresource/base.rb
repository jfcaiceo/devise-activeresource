module Devise
  module Activeresource
    module Base
      module ClassMethods
        def to_adapter
          @to_adapter ||= Devise::Activeresource::Adapter.new(self)
        end

        def increment_counter(counter_name, id)
          element = find(id)
          return false if element.nil?

          value = element.send(counter_name)
          element.send("#{counter_name}=", value + 1)
          element.save
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
