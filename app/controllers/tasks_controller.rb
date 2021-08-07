class TasksController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
    @task = @category.tasks.create(task_params)
    if @task.save
      #redirect_to category_path(@category)
      redirect_to @task.category
    else
      render :new
    end
  end



  private
    def task_params
      params.require(:task).permit(:name, :description, :priority, :deadline, :completed)
    end
end
