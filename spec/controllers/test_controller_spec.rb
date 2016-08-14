require 'rails_helper'

RSpec.describe TestController, type: :controller do
  describe "GET /test/members_only" do

    context 'unauthorized user' do
      it "responds unsuccessfully with an HTTP 200 status code" do
        get "members_only"
        expect(response).to have_http_status(:unauthorized)
      end
    end

    # context 'unauthorized user' do
    #   before(:each) do
    #     @request.env['devise.mapping'] = Devise.mappings[:user]
    #     sign_in create(:user) # TODO find another way to sing in
    #   end

    #   it "responds unsuccessfully with an HTTP 200 status code" do
    #     get "members_only"
    #     expect(response).to be_success
    #     expect(response).to have_http_status(200)
    #   end
    # end
  end
end
