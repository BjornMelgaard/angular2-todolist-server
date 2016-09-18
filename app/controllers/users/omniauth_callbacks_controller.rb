class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if not @user.persisted?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      @user.save!
    end
    sign_in @user, :event => :authentication #this will throw if @user is not activated
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end
end
