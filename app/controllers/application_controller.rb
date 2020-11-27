class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_address, only: [:edit, :update], if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date, :avatar])
    devise_parameter_sanitizer.permit(:acount_update, keys: [:nickname, :avatar])
  end

  def set_address
    @address = current_user.address
  end
end
