module RequestMacros
  def create_user_attributes
    before do
      @user_attr = FactoryGirl.attributes_for(:user)
    end
  end

  def create_registered_user
    create_user_attributes
    before do
      @user = User.create(@user_attr)
      @token = Tiddle.create_and_return_token(@user, FakeRequest.new)
      @headers = {
        "X-USER-EMAIL" => @user.email,
        "X-USER-TOKEN" => @token
      }
    end
  end
end
