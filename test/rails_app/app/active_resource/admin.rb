require 'shared_admin'

class Admin < ActiveResource::Base
  devise :database_authenticatable, :registerable,
         :timeoutable, :recoverable, :lockable, :confirmable,
         :resource_authenticatable,
         unlock_strategy: :time, lock_strategy: :none,
         allow_unconfirmed_access_for: 2.weeks, reconfirmable: true

  include Shim
  self.site = 'http://localhost:3000'
end
