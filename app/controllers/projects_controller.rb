class ProjectsController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :load_project, only: [:update, :destroy]

  def index
    render json: current_user.projects, include: ['tasks.comments.attachments']
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.persisted?
      render json: @project, status: :created
    else
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project, status: :created
    else
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: @project.destroy
  end

  private
  def load_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end

end