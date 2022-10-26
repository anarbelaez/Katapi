class TasksController < ApplicationController
  before_action :set_goal, only: %i[new create index]
  before_action :set_task, only: %i[show edit update destroy update_task]
  before_action :goal_policy, only: %i[index new]
  before_action :task_policy, only: %i[show edit delete]

  def index
    @tasks = @goal.tasks
    @todo = @tasks.not_started
    @doing = @tasks.in_progress
    @done = @tasks.done
    @tasks = @tasks.search(params[:query]) if params[:query].present?
    @pagy, @tasks = pagy @tasks.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)
  end

  def all_tasks
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.goal = @goal
    @task.save
    if @task.save
      redirect_to goal_tasks_path
    else
      render :new, status: :unprocessable_entity, alert: "Change a few things and try submitting again"
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task), notice: "Your changes have been saved successfully"
  end

  def update_task
    @task.update(task_params)
  end

  def calendar
    @tasks = current_user.tasks
  end

  def destroy
    @task.destroy
    redirect_to goal_tasks_path(@task.goal), status: :see_other, notice: "Your goal has been deleted"
  end

  #Metodos de datatable

  def sort_column
    %w[name priority difficulty due_date].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :status, :priority, :difficulty, :due_date, :goal_id, :review)
  end

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_policy
    set_task
    redirect_to activity_path, alert: "You don't have permission to access this page" unless current_user == @task.user
  end

  def goal_policy
    set_goal
    redirect_to activity_path, alert: "You don't have permission to access this page" unless current_user == @goal.user
  end
end
