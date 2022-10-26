class TasksController < ApplicationController
  before_action :set_goal, only: %i[new create index]
  before_action :set_task, only: %i[show edit update destroy update_task]
  before_action :task_policy, only: %i[show edit delete]
  before_action :goal_policy, only: %i[index new]

  def index
    @tasks = @goal.tasks
    @todo = @tasks.not_started
    @doing = @tasks.in_progress
    @done = @tasks.done
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def update_task
    @task.update(task_params)
  end

  def calendar
    @tasks = current_user.tasks
  end

  def destroy
    @task.destroy
    redirect_to goal_tasks_path(@task.goal), status: :see_other
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
    user = @task.user
    redirect_to activity_path unless current_user == user
  end

  def goal_policy
    set_goal
    redirect_to activity_path unless current_user == @goal.user
  end
end
