module CategoriesHelper

    def get_user_name(user_id)
        @user_name = User.find_by(id: user_id)
        @user_name.email.slice(0..@user_name.email.index('@') - 1)
    end

    def percent_progress(category_id)
        @task_completed = Task.where(category_id: category_id, completed: true).count
        @total_task = Task.where(category_id: category_id).count
        @percent_progress = ((@task_completed / @total_task) * 100).round(2)
    end
end
