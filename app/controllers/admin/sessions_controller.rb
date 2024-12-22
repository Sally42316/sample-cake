class Admin::SessionsController < Devise::SessionsController
  protected
  def after_sign_in_path_for(resource)
    admin_items_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # GET /admin/sign_in
  # def new
  #   super
  # end

  # # POST /admin/sign_in
  # def create
  #   super
  # end

  # # DELETE /admin/sign_out
  # def destroy
  #   super
  # end

  # protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
