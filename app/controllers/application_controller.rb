class ApplicationController < ActionController::Base
    acts_as_token_authentication_handler_for User
    
    protect_from_forgery with: :exception
    # before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
