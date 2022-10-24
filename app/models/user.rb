class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :goals, dependent: :destroy
  has_many :tasks, through: :goals
  has_one_attached :photo

  # validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  # validates :nickname, uniqueness: true

  # Scopes
  def goal_categories
    goals.distinct.pluck(:category)
  end

  def seed_count
    goals.seed.count
  end

  def sapling_count
    goals.sapling.count
  end

  def mature_tree_count
    goals.mature_tree.count
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
