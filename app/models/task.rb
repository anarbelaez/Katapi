class Task < ApplicationRecord
  include PgSearch::Model

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

  private


end
