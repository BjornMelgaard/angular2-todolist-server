class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render json: { user: { email: user.email, token: token } }
  end

  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {message: I18n.t('devise.sessions.signed_out')}
  end

  private
    # this is invoked before destroy and we have to override it
    def verify_signed_out_user
    end
end