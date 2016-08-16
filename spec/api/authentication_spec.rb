require 'rails_helper'

RSpec.describe "auth", :type => :request do
  let(:user_attr) { FactoryGirl.attributes_for(:user) }

  context "user unregistered" do

    it "can register, login and don't allow double registration" do
      post '/auth/register', params: { user: user_attr }, as: :json
      expect_json_types(id: :int, email: :string)

      post '/auth/login', params: { user: user_attr }, as: :json
      expect_json_types(authentication_token: :string)

      post '/auth/register', params: { user: user_attr }, as: :json
      expect_json(errors: {:email=>["has already been taken"]})
    end

  end

  context "user registered" do
    before do
      @user = FactoryGirl.create(:user)
      @token = Tiddle.create_and_return_token(@user, FakeRequest.new)
      @headers = {
        "X-USER-EMAIL" => @user.email,
        "X-USER-TOKEN" => @token
      }
    end

    it "allow secret resource" do
      get '/test/members_only', headers: @headers, as: :json
      expect(response).to be_success
    end

    it "don't allow secret resource to signed out user" do
      delete '/auth/logout', headers: @headers, as: :json
      expect(response).to be_success

      get '/test/members_only', headers: @headers, as: :json
      expect(response).not_to be_success
    end

  end

end
