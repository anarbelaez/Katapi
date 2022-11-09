class Goal < ApplicationRecord
  include PgSearch::Model

  # after_create_commit :notify_user

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

  scope :by_status, ->(maturity) { where('maturity = ?', maturity) }

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

  def completed?
    done_tasks_fraction.to_d == 1.0.to_d
  end

  def dead?
    if tasks.present?
      last_task_date = tasks.order(:due_date).last.due_date
      done_tasks_fraction.to_d != 1.0.to_d && last_task_date < Date.today
    else
      false
    end
  end

  def dying?
    if tasks.present?
      last_task_date = tasks.order(:due_date).last.due_date
      done_tasks_fraction.to_d < 1.0.to_d && (last_task_date - Date.today).to_i <= 5
    else
      false
    end
  end

  def notify_user
    GoalNotification.with(goal: self).deliver_later(user)
  end
end
