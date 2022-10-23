class TasksController < ApplicationController
  before_action :set_goal, only: %i[new create index]
  before_action :set_task, only: %i[show edit update destroy update_task]

  def index
    @tasks = policy_scope(Task)
    @tasks = @goal.tasks
    @todo = @tasks.not_started
    @doing = @tasks.in_progress
    @done = @tasks.done
  end

  def show
    authorize @task
  end

  def new
    @task = Task.new
    authorize @task
  end

  def create
    @task = Task.new(task_params)
    @task.goal = @goal
    authorize @task
    @task.save
    if @task.save
      redirect_to goal_tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def update_task
    @task.update(task_params)
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to goal_tasks_path(@task.goal), status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :priority, :difficulty, :due_date, :goal_id, :review)
  end

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
