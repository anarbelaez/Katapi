class TasksController < ApplicationController
  before_action :set_goal, only: %i[new create]
  before_action :set_task, only: %i[show edit update destroy]
  def index
    @tasks = Task.all
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

  def destroy
    @task.destroy
    redirect_to goal_tasks_path(@task.goal), status: :see_other
  end

  private
  def task_params
    params.require(:task).permit(:name, :status, :priority, :difficulty, :due_date, :goal_id)
  end

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
