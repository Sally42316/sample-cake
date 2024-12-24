class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :set_search

  def after_sign_in_path_for(resource)
   case resource
    when Admin
     admin_root_path
    when Customer
     customers_mypage_path
   end
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  def set_search
  @search = Item.ransack(params[:q])
  end

  protected

 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :family_name, :first_name, :family_name_kana, :first_name_kana, :post_code, :address, :tell_number])
 end
end
