class Goal < ApplicationRecord
  belongs_to :user
  has_many :tasks

  validates :name, :category, :user, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { maximum: 200 }

  enum maturity: { seed: 0, sapling: 1, mature_tree: 2 }
end
