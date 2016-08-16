class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      render json: user.as_json, status: :created
    else
      warden.custom_failure!
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    Tiddle.expire_token(current_user, request) if current_user
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {message: I18n.t('devise.registrations.destroyed')}
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end
end
