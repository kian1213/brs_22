class Review < ActiveRecord::Base
  include PublicActivity::Common
  has_many :comments
  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :rate, presence: true
end
