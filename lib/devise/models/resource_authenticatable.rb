module Devise
  module Models
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
