class TasksController < ApplicationController
  before_action :set_goal, only: %i[new create index]
  before_action :set_task, only: %i[show edit update destroy update_task]

  def index 
    @tasks = Task.all if current_user
    @tasks = @goal.tasks
    @todo = @tasks.not_started
    @doing = @tasks.in_progress
    @done = @tasks.done
    @tasks = @tasks.search(params[:query]) if params[:query].present?
    @pagy, @tasks = pagy @tasks.reorder(sort_column => sort_direction), items: params.fetch(:count, 10)
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
    @tasks = Task.all
  end

  def destroy
    @task.destroy
    redirect_to goal_tasks_path(@task.goal), status: :see_other
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
end
