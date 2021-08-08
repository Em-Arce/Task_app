class TasksController < ApplicationController
  before_action :authenticate_user!
  #before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: %i[create]
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.where(user_id: current_user.id, deadline: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order(priority: :asc)
  end

  def new
    @task = @category.tasks.build
  end

  def show
  end

  def create
    @task = @category.tasks.create(task_params.merge(user_id: current_user.id))
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.category, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task.category }
      else
        format.html { redirect_to @task.category, notice: "Invalid inputs." }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_task
      @task = Task.where(user_id: current_user.id).find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :priority, :deadline, :completed, :user_id, :category_id)
    end
end
