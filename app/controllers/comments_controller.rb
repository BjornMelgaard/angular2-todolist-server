class CommentsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      puts params[:attachments]
      Attachment.where(id: params[:attachments]).update_all(comment_id: @comment.id)
      render json: @comment
    else
      render json: { errors: @comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    render json: @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :task_id)
  end
end
