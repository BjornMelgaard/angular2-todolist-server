class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.all  { render :nothing => true, :status => :not_found }
    end
  end
end
