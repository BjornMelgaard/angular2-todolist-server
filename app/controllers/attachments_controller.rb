class AttachmentsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  def create
    @attachment = Attachment.new(file: params[:file])
    if @attachment.save
      render json: @attachment.to_json
    else
      render json: { errors: @attachment.errors }, status: :unprocessable_entity
    end
  end
end
