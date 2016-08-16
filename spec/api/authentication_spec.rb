require 'rails_helper'

RSpec.describe "auth", :type => :request do
  let(:user_attr) { FactoryGirl.attributes_for(:user) }

  it "registration" do
    post '/auth/register',
      params: { user: user_attr },
      as: :json
    expect_json_types(id: :int, email: :string)

    post '/auth/register',
      params: { user: user_attr },
      as: :json
    expect_json(errors: {:email=>["has already been taken"]})

    post '/auth/login',
      params: { user: user_attr },
      as: :json
    expect_json_types(authentication_token: :string)

    headers = {
      "X-USER-EMAIL" => user_attr[:email],
      "X-USER-TOKEN" => json_body[:authentication_token]
    }
    get '/test/members_only',
      headers: headers,
      as: :json
    expect(response).to be_success

    delete '/auth/logout',
      headers: headers,
      as: :json
    expect(response).to be_success

    get '/test/members_only',
      headers: headers,
      as: :json
    expect(response).not_to be_success

    post '/auth/login',
      params: { user: user_attr },
      as: :json
    expect_json_types(authentication_token: :string)

    headers = {
      "X-USER-EMAIL" => user_attr[:email],
      "X-USER-TOKEN" => json_body[:authentication_token]
    }

    delete '/auth/register',
      headers: headers,
      as: :json
    expect(response).to be_success

    delete '/auth/register',
      headers: headers,
      as: :json
    expect(response).not_to be_success
  end

end
