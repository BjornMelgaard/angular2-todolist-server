class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    require "pry"; binding.pry;
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render id: user.id, email: user.email, authentication_token: token
  end

  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {}
  end

  private

    # this is invoked before destroy and we have to override it
    def verify_signed_out_user
    end
end