class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: %i[index edit]
  before_action :set_task, only: %i[show update destroy]

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

  def edit
    @category = Category.find(params[:category_id])
    @task = @category.tasks.find(params[:id])
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
          format.html { redirect_to @task.category, notice: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
      else
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @task.category, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_task
      @task = @category.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :priority, :deadline, :completed, :user_id, :category_id)
    end
end
