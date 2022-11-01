class Goal < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one_attached :photo
  has_rich_text :rich_body

  pg_search_scope :search,
                  against: %i[name description],
                  using: { tsearch: { prefix: true } }

  validates :name, :category, :user, presence: true
  validates :name, length: { minimum: 5, maximum: 60 }
  validates :description, length: { maximum: 200 }

  enum maturity: { baby: 0, young: 1, adult: 2 }

  # pockie_maturity = pockie.goals.group(:maturity).count
  # pockie_maturity.key(pockie_maturity.values.max)

  # Fractions
  def not_started_tasks_fraction
    return tasks.not_started.count.fdiv(tasks.count) if tasks.count.positive?
  end

  def in_progress_tasks_fraction
    return tasks.in_progress.count.fdiv(tasks.count) if tasks.count.positive?
  end

  def done_tasks_fraction
    return tasks.done.count.fdiv(tasks.count) if tasks.count.positive?
  end

  # def goal_maturity!
  #   if done_tasks_fraction >= 0.25 && done_tasks_fraction <= 0.5
  #     update_attribute(:maturity, 1)
  #   else
  #     update_attribute(:maturity, 2)
  #   end
  # end
end
