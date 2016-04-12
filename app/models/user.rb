class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  has_many :requests
  has_many :user_books
  has_many :reviews
  has_many :favorites
  has_many :likes
  has_many :comments
  has_many :activities
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id,
    dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id,
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  def full_name
    [first_name, last_name].join(" ")
  end
end
