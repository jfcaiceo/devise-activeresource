require "devise/activeresource/railtie"
require 'devise/activeresource/base'

module Devise
  module Activeresource
  end
end

require 'devise/activeresource/adapter' if defined?(ActiveResource::Base)
