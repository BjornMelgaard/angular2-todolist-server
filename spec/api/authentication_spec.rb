require 'rails_helper'

RSpec.describe "AUTH:", :type => :request do
  let(:user_attr) { FactoryGirl.attributes_for(:user) }

  context "unregistered user" do
    it "can't login with false credentials" do
      post '/auth/login', params: { user: user_attr }, as: :json
      expect(response).not_to be_success
    end

    it "can register and don't allow double registration" do
      post '/auth/register', params: { user: user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })

      @headers = {
        "X-USER-EMAIL" => json_body[:user][:email],
        "X-USER-TOKEN" => json_body[:user][:token]
      }
      get '/test/members_only', headers: @headers, as: :json
      expect(response).to be_success

      post '/auth/register', params: { user: user_attr }, as: :json
      expect_json(errors: {:email=>["has already been taken"]})
    end
  end

  context "registered user" do
    before do
      @user_attr = user_attr
      @user = User.create(@user_attr)
      @token = Tiddle.create_and_return_token(@user, FakeRequest.new)
      @headers = {
        "X-USER-EMAIL" => @user.email,
        "X-USER-TOKEN" => @token
      }
    end

    it "can login after registration" do
      post '/auth/login', params: { user: @user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })
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

      post '/auth/login', params: { user: @user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })
    end

  end

end
