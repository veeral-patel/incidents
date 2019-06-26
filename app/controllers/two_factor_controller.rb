class TwoFactorController < ApplicationController
    def index
        @two_factor_enabled = current_user.otp_required_for_login
    end

    def activate
        current_user.unconfirmed_otp_secret = User.generate_otp_secret
        current_user.save!
        @qr_code = RQRCode::QRCode.new(two_factor_url).to_img.resize(240, 240).to_data_url
        current_user.activate_otp
        render :qr
    end

    def deactivate
        current_user.deactivate_otp
        redirect_back(fallback_location: root_path)
    end

    def two_factor_url
        app_name = "INCIDENTS"
        "otpauth://totp/#{current_user.email}?secret=#{current_user.unconfirmed_otp_secret}&issuer=#{app_name}"
    end
end
