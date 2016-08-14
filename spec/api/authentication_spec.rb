require 'rails_helper'

RSpec.describe "auth", :type => :request do

  it "registrarion" do
    post '/users/register',
      params: FactoryGirl.attributes_for(:user),
      as: :json
    require "pry"; binding.pry;
    expect_json_types(id: :int, email: :string, authentication_token: :string)

  end
end
