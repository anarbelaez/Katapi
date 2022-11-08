class UsersController < ApplicationController
  def activity
    @user = current_user
    @tasks = @user.tasks
    @goals = @user.goals

    # Upcoming tasks
    @upcoming_tasks_day = @user.tasks_grouped_by_day.keys[0]
    @upcoming_tasks = @user.tasks_grouped_by_day.values[0]

    # Percentages
    @baby_percentage = (@user.baby_goals_fraction * 100).round
    @young_percentage = (@user.young_goals_fraction * 100).round
    @adult_percentage = (@user.adult_goals_fraction * 100).round

    # Tasks counts
    @not_started_tasks = current_user.tasks.not_started.count
    @in_progress_tasks = current_user.tasks.in_progress.count
    @done_tasks = current_user.tasks.done.count



    # if @goals.count > 0
    #   @seed_percentage = (@user.seed_count.fdiv(@goals.count) * 100).round
    #   @sapling_percentage = (@user.sapling_count.fdiv(@goals.count) * 100).round
    #   @mature_tree_percentage = (@user.mature_tree_count.fdiv(@goals.count) * 100).round
    # end

    # def search
    #   if params[:query].present?
    #     @query = params[:query]
    #     @products = Product.search(params[:query]).available
    #   else
    #     @products = Product.available
    #   end
    # end
  end

  # def send_notification
  #   current_user.goals.each do |goal|
  #     if goal.dying? || goal.dead?
  #       goal.notify_user
  #     end
  #   end
  # end

  def show
    @user = current_user
  end
end
