class TestController < ApplicationController
  before_action :authenticate_user!

    def members_only
      # require "pry"; binding.pry;

      render json: {
        data: {
          message: "Welcome #{current_user.name}",
          user: current_user
        }
      }, status: 200
    end
end
