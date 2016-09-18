require 'rails_helper'

RSpec.describe "AUTH:", :type => :request do
  context "unregistered user" do
    create_user_attributes

    it "can't login with false credentials" do
      post '/api/auth/login', params: { user: @user_attr }, as: :json
      expect(response).not_to be_success
    end

    it "can register and don't allow double registration" do
      post '/api/auth/register', params: { user: @user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })

      @headers = {
        "X-USER-EMAIL" => json_body[:user][:email],
        "X-USER-TOKEN" => json_body[:user][:token]
      }
      get '/api/projects', headers: @headers, as: :json
      expect(response).to be_success

      post '/api/auth/register', params: { user: @user_attr }, as: :json
      expect_json(errors: {:email=>["has already been taken"]})
    end
  end

  context "registered user" do
    create_registered_user

    it "can't register" do
      post '/api/auth/register', params: { user: @user_attr }, as: :json
      expect_json(errors: {:email=>["has already been taken"]})
    end

    it "can login after registration" do
      post '/api/auth/login', params: { user: @user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })
    end

    it "allow secret resource" do
      get '/api/projects', headers: @headers, as: :json
      expect(response).to be_success
    end

    it "don't allow secret resource to signed out user" do
      delete '/api/auth/logout', headers: @headers, as: :json
      expect(response).to be_success

      get '/api/projects', headers: @headers, as: :json
      expect(response).not_to be_success

      post '/api/auth/login', params: { user: @user_attr }, as: :json
      expect_json_types(user: { email: :string, token: :string })
    end

  end

end
