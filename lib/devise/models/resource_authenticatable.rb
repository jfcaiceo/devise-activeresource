module Devise
  module Models
    # Authenticatable Module, responsible for hashing the password and
    # validating the authenticity of a user while signing in.
    #
    # == Options
    #
    # DatabaseAuthenticatable adds the following options to devise_for:
    #
    #   * +pepper+: a random string used to provide a more secure hash. Use
    #     `rails secret` to generate new keys.
    #
    #   * +stretches+: the cost given to bcrypt.
    #
    #   * +send_email_changed_notification+: notify original email when it changes.
    #
    #   * +send_password_change_notification+: notify email when password changes.
    #
    # == Examples
    #
    #    User.find(1).valid_password?('password123')         # returns true/false
    #
    module ResourceAuthenticatable
      def update_with_password(params)
        current_password = params.delete(:current_password)

        if params[:password].blank?
          params.delete(:password)
          params.delete(:password_confirmation) if params[:password_confirmation].blank?
        end

        result = if valid_password?(current_password)
                   update_attributes(params)
                 else
                   assign_attributes(params)
                   valid?
                   errors.add(:current_password, current_password.blank? ? :blank : :invalid)
                   false
                 end

        clean_up_passwords
        result
      end

      def update_without_password(params)
        params.delete(:password)
        params.delete(:password_confirmation)

        result = update_attributes(params)
        clean_up_passwords
        result
      end
    end
  end
end
