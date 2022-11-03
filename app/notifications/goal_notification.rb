# To deliver this notification:
#
# GoalNotification.with(post: @post).deliver_later(current_user)
# GoalNotification.with(post: @post).deliver(current_user)

class GoalNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :goal

  # Define helper methods to make rendering easier.
  def message
    params[:goal].name
  end

  def url
    goal_path(params[:goal])
  end
end
