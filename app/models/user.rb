class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :goals
  has_many :tasks, through: :goals
  has_one_attached :photo

  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates :nickname, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end
end
