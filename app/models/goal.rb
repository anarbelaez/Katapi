class Goal < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many :tasks
  has_one_attached :photo
  has_rich_text :rich_body

  pg_search_scope :search,
                  against: %i[name description],
                  using: { tsearch: { prefix: true } }

  validates :name, :category, :user, presence: true
  validates :name, length: { minimum: 5 }
  validates :description, length: { maximum: 200 }

  enum maturity: { seed: 0, sapling: 1, mature_tree: 2 }


end
