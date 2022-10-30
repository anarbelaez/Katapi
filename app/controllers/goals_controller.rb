class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]
  before_action :new_goal, only: %i[index new]
  before_action :goal_policy, only: %i[show edit destroy]

  def index
    @pagy, @goals = pagy(current_user.goals)
    @tasks = current_user.tasks
  end

  def show
    @task = Task.new
    @todo = @goal.tasks.not_started
    @doing = @goal.tasks.in_progress
    @done = @goal.tasks.done
  end

  def new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    @goal.save
    if @goal.save
      redirect_to goal_path(@goal)
    else
      render :new, status: :unprocessable_entity, alert: "Change a few things and try submitting again"
    end
  end

  def edit
  end

  def update
    @goal.update(goal_params)
    redirect_to goal_path(@goal), notice: "Your changes have been saved successfully"
  end

  def destroy
    @goal.destroy
    redirect_to goals_path, status: :see_other, notice: "Your goal has been deleted"
  end

  def by_category
    @goals = Goal.all
  end

  private

  def new_goal
    @goal = Goal.new
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :description, :category, :review, :maturity, :completion_date, :user_id)
  end

  def goal_policy
    set_goal
    redirect_to activity_path, alert: "You don't have permission to access this page" unless current_user == @goal.user
  end
end
