# frozen_string_literal: true

require 'shared_user'

class User < ActiveResource::Base
  include Shim
  self.site = 'http://localhost:3000'

  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
         :registerable, :rememberable, :timeoutable,
         :trackable, :omniauthable, :resource_authenticatable,
         reconfirmable: false

  cattr_accessor :validations_performed

  after_validation :after_validation_callback

  def after_validation_callback
    # used to check in our test if the validations were called
    @@validations_performed = true
  end
end
