class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]

  def index
    @goals = policy_scope(Goal)
    @goal = Goal.new
  end

  def show
    @task = Task.new
    # redirect_to activity_path unless @goal.user == current_user
    authorize @goal
  end

  def new
    @goal = Goal.new
    authorize @goal
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    authorize @goal
    @goal.save
    if @goal.save
      redirect_to goal_path(@goal)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    autorize @goal
  end

  def update
    autorize @goal
    @goal.update(goal_params)
    redirect_to goal_path(@goal)
  end

  def destroy
    autorize @goal
    @goal.destroy
    # dashboard
    redirect_to goals_path, status: :see_other
  end

  private

  def goal_params
    params.require(:goal).permit(:name, :description, :category, :review, :maturity, :completion_date, :user_id)
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end
end
