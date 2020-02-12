require 'devise'
require 'devise/activeresource/base'
require 'devise/activeresource/patch_methods'
require 'devise/models/resource_authenticatable'

module Devise
  module Activeresource
  end
end

if defined?(ActiveResource::Base)
  require 'devise/activeresource/adapter'
  Devise.add_module :resource_authenticatable, model: 'devise/models/resource_authenticatable'
end
