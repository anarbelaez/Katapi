class Task < ApplicationRecord
  include PgSearch::Model

  # Callback
  after_update :goal_maturity!

  belongs_to :goal
  has_one_attached :photo
  has_rich_text :rich_body

  pg_search_scope :search, against: %i[name description priority difficulty], using: { tsearch: { prefix: true } }

  validates :name, :status, :priority, :difficulty, :goal, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { maximum: 200 }

  enum status: { not_started: 0, in_progress: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
  enum difficulty: { easy: 0, meddium: 1, hard: 2 }

  def user
    goal.user
  end

  def start_time
    due_date
  end

  def goal_maturity!
    goal_tasks = goal.tasks
    tasks_count = goal_tasks.count
    done_tasks_fraction = goal_tasks.done.count.fdiv(tasks_count)

    if done_tasks_fraction >= 0.25 && done_tasks_fraction <= 0.5
      goal.update_attribute(:maturity, 1)
    else
      goal.update_attribute(:maturity, 2)
    end
  end
end
