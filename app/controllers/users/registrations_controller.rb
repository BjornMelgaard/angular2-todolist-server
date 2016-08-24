class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      token = Tiddle.create_and_return_token(user, request)
      render json: { user: { email: user.email, token: token } }, status: :created
    else
      warden.custom_failure!
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    render json: {message: I18n.t('devise.registrations.destroyed')}
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
