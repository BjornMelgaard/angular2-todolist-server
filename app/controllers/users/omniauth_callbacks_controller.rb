class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # require "pry"; binding.pry;
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if not @user.persisted?
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      @user.save!
    end
    sign_in @user, :event => :authentication #this will throw if @user is not activated
    @token = Tiddle.create_and_return_token(@user, request)
    @auth_params = { user: { email: @user.email, token: @token } }

    url = generate_url(auth_origin_url, @auth_params)
    puts url
    redirect_to url
  end

  def failure
    redirect_to auth_origin_url
  end

  def auth_origin_url
    request.env["omniauth.origin"]
  end

  def generate_url(url, params = {})
    uri = URI(url)

    res = "#{uri.scheme}://#{uri.host}"
    res += ":#{uri.port}" if (uri.port and uri.port != 80 and uri.port != 443)
    res += "#{uri.path}" if uri.path
    query = [uri.query, params.to_query].reject(&:blank?).join('&')
    res += "?#{query}"
    res += "##{uri.fragment}" if uri.fragment

    return res
  end

end
