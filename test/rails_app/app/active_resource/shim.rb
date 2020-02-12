module Shim
  extend ::ActiveSupport::Concern

  included do
    attr_accessor :persisted
    cattr_accessor :model_counts
    schema do
      string 'username', 'email', 'encrypted_password', 'reset_password_token',
             'confirmation_token', 'unconfirmed_email', 'unlock_token',
             'current_sign_in_ip', 'last_sign_in_ip'
      integer 'sign_in_count', 'failed_attempts'
      timestamp 'reset_password_sent_at', 'remember_created_at', 'confirmed_at',
                'confirmation_sent_at', 'locked_at', 'current_sign_in_at',
                'last_sign_in_at'
      boolean 'active'
    end
  end

  def save(*)
    if new?
      self.persisted = true
      return true
    end

    unless reset_password_token.nil?
      ActiveResource::HttpMock.respond_to(false) do |mock|
        mock.get("/#{self.class.to_s.tableize}.json?reset_password_token=#{reset_password_token}", {}, [attributes].to_json)
      end
    end
    super
  end

  module ClassMethods
    def create!(attributes = {})
      encrypted_password = Devise::Encryptor.digest(self, attributes[:password])
      model_attributes = {
        id: 1,
        username: attributes[:username],
        ## Database authenticatable
        email: attributes[:email],
        encrypted_password: encrypted_password,
        ## Recoverable
        reset_password_token: attributes[:reset_password_token],
        reset_password_sent_at: attributes[:reset_password_sent_at] || Time.now.to_s,
        ## Rememberable
        remember_created_at: attributes[:remember_created_at],
        ## Trackable
        sign_in_count: attributes[:sign_in_count] || 0,
        current_sign_in_at: attributes[:current_sign_in_at],
        last_sign_in_at: attributes[:last_sign_in_at],
        current_sign_in_ip: attributes[:current_sign_in_ip],
        last_sign_in_ip: attributes[:last_sign_in_ip],
        ## Confirmable
        confirmation_token: attributes[:confirmation_token],
        confirmed_at: attributes[:confirmed_at] || Time.now.to_s,
        confirmation_sent_at: attributes[:confirmation_sent_at],
        unconfirmed_email: attributes[:unconfirmed_email],
        ## Lockable
        failed_attempts: attributes[:failed_attempts] || 0,
        unlock_token: attributes[:unlock_token],
        locked_at: attributes[:locked_at],
        active: attributes[:active] || true
      }

      ActiveResource::HttpMock.respond_to(false) do |mock|
        mock.get("/#{to_s.tableize}.json?email=#{CGI.escape(attributes[:email])}", {}, [model_attributes].to_json)
        mock.get("/#{to_s.tableize}/1.json", {}, model_attributes.to_json)
        mock.put("/#{to_s.tableize}/1.json", {}, nil)
        mock.patch("/#{to_s.tableize}/1.json", {}, nil)
      end

      self.model_counts = (model_counts || 0) + 1
      initialize_model_after_create(attributes, model_attributes, encrypted_password)
    end

    def count
      model_counts
    end

    def destroy_all
      self.model_counts = 0
      ActiveResource::HttpMock.reset!
    end

    def initialize_model_after_create(attributes, model_attributes, encrypted_password)
      model = new(model_attributes)
      if attributes.key?(:password)
        model.password = attributes[:password]
        model.encrypted_password = encrypted_password
      end
      if attributes.key?(:password_confirmation)
        model.password_confirmation = attributes[:password_confirmation]
      end
      model.persisted = true
      model
    end
  end
end
