class UsersController < ApplicationController
  def activity
    @user = current_user
    @tasks = @user.tasks
    @goals = @user.goals

    @seed_percentage = (@user.seed_count.fdiv(@goals.count) * 100).round || 0
    @sapling_percentage = (@user.sapling_count.fdiv(@goals.count) * 100).round || 0
    @mature_tree_percentage = (@user.mature_tree_count.fdiv(@goals.count) * 100).round || 0

    # def search
    #   if params[:query].present?
    #     @query = params[:query]
    #     @products = Product.search(params[:query]).available
    #   else
    #     @products = Product.available
    #   end
    # end
  end

  def show
    @user = current_user
  end
end
