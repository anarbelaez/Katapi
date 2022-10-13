class Task < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :name, :status, :priority, :difficulty, :due_date, :goal, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { maximum: 200 }

end
