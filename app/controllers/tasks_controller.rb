class TasksController < ApplicationController
  before_action :authenticate_user!
  #before_action :correct_user, only: [:show, :edit, :update, :destroy]
  #before_action :set_category, only: %i[create]
  before_action :set_task, only: %i[show edit update destroy]

  def new
    @task = @category.tasks.build
    #@task = current_user.tasks.build
  end

  def show; end

  def create
    @category = Category.find(params[:category_id])
    @task = @category.tasks.create(task_params)
    if @task.save
      redirect_to @task.category
      #@task.category
    else
      render :new
    end
  end

  private


    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :priority, :deadline, :completed, :user_id, :category_id)
    end
end
