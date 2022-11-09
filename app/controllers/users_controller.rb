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

    dead_count = 0
    @goals.each { |goal| dead_count += 1 if goal.dead? }
    @dead_count = dead_count
    @alive_count = @goals.count - dead_count
    if @goals.present?
      @alive_percentage = (@alive_count.fdiv(@goals.count) * 100).round
      @dead_percentage = (@dead_count.fdiv(@goals.count) * 100).round
    end
    @goal_information = @goals.map do |goal|
      {
        id: goal.id,
        name: goal.name,
        description: goal.description,
        category: goal.category,
        date: goal.completion_date
      }
    end
  end

  def show
    @user = current_user
  end

  # def send_notification
  #   current_user.goals.each do |goal|
  #     if goal.dying? || goal.dead?
  #       goal.notify_user
  #     end
  #   end
  # end
end
