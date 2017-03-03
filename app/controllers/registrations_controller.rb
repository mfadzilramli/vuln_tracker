# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def update
    @user.update(password_params)
    redirect_to root_path
  end

  private

  def password_params
    params.fetch(:user, {}).permit(:password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
