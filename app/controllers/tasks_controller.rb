class TasksController < ApplicationController
  respond_to :json

  before_action :authenticate_user!
  before_action :load_task, only: [:update, :destroy, :done, :sort, :deadline]

  def create
    render json: @task = Task.create(task_params)
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: @task.destroy
  end

  def done
    @task.update(done: params[:done])
    render json: @task
  end

  def sort
    @task.set_list_position(params[:position].to_i + 1)
    render json: @task
  end

  def deadline
    @task.update(deadline: params[:deadline])
    puts params
    render json: @task
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :project_id)
  end
end
