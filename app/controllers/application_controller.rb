class ApplicationController < ActionController::Base
    include Pundit

    acts_as_token_authentication_handler_for User
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    skip_before_action :verify_authenticity_token, if: :json_request?
    before_action :ensure_subdomain_is_provided

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    protected
    def ensure_subdomain_is_provided
        if request.subdomain.empty?
            flash[:alert] = "Subdomain cannot be empty"
        end
    end

    def configure_permitted_parameters
        added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
    end

    def json_request?
        request.format.json?
    end

    private
  
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
