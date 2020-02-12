module Devise
  module Activeresource
    # Adapter based on orm_adapter interface
    # https://github.com/ianwhite/orm_adapter/blob/master/lib/orm_adapter/base.rb
    class Adapter
      attr_reader :klass

      def initialize(klass)
        @klass = klass
      end

      # Get a list of column/property/field names
      def column_names
        klass.attributes
      end

      # Get an instance by id of the model. Raises an error if a model is not found.
      # This should comply with ActiveModel#to_key API, i.e.:
      #
      #   User.to_adapter.get!(@user.to_key) == @user
      #
      def get!(id)
        klass.find(wrap_key(id))
      end

      # Get an instance by id of the model. Returns nil if a model is not found.
      # This should comply with ActiveModel#to_key API, i.e.:
      #
      #   User.to_adapter.get(@user.to_key) == @user
      #
      def get(id)
        klass.find(wrap_key(id))
      rescue ActiveResource::ResourceNotFound
        nil
      end

      # Find the first instance, optionally matching conditions
      #
      # You can call with just conditions, providing a hash
      #
      #   User.to_adapter.find_first :name => "Fred", :age => 23
      #
      #   User.to_adapter.find_first :conditions => {:name => "Fred", :age => 23}
      #
      def find_first(options = {})
        conditions, limit, offset = extract_conditions!(options)
        params = conditions.merge(limit_offset_hash(limit, offset))
        klass.find(:first, params: params)
      rescue ActiveResource::InvalidRequestError
        nil
      end

      # Find all models, optionally matching conditions, and specifying order
      # @see OrmAdapter::Base#find_first for how to specify order and conditions
      def find_all(options = {})
        conditions, limit, offset = extract_conditions!(options)
        params = conditions.merge(limit_offset_hash(limit, offset))
        klass.find(:all, params: params)
      end

      # Create a model using attributes
      def create!(attributes = {})
        klass.create(attributes)
      end

      # Destroy an instance by passing in the instance itself.
      def destroy(object)
        object.destroy
      end

      protected

      def valid_object?(object)
        object.class == klass
      end

      def wrap_key(key)
        key.is_a?(Array) ? key.first : key
      end

      # given an options hash,
      # with optional :conditions, :limit and :offset keys,
      # returns conditions, limit and offset
      def extract_conditions!(options = {})
        _order     = options.delete(:order)
        limit      = options.delete(:limit)
        offset     = options.delete(:offset)
        conditions = options.delete(:conditions) || options

        [conditions, limit, offset]
      end

      def limit_offset_hash(limit, offset)
        response = {}
        response[:limit] = limit if limit && limit > 1
        response[:offset] = offset if offset && offset > 1
        response
      end
    end
  end
end

ActiveSupport.on_load(:active_resource) do
  prepend ::Devise::Activeresource::PatchMethods
  include ::Devise::Activeresource::Base
end
