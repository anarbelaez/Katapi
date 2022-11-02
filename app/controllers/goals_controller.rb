class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]
  before_action :new_goal, only: %i[index new]
  before_action :goal_policy, only: %i[show edit destroy]

  def index
    if params[:query].present?
      @pagy, @goals = pagy(current_user.goals.where("name like ?", "%#{params[:query]}%"))
    else
      @pagy, @goals = pagy(current_user.goals)
    end

    if turbo_frame_request?
      render partial: "goals", locals: { goals: @goals }
    else
      render :index
    end
  end

  def show
    @task = Task.new
    @todo = @goal.tasks.not_started
    @doing = @goal.tasks.in_progress
    @done = @goal.tasks.done

    time = (0..19).include?(Time.now.hour) ? "day" : "night"
    @goal_tree = {
      maturity: "baby",
      status: "alive",
      landscape_type: time,
      completed: true
    }.to_json
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
