class Book < ActiveRecord::Base
  has_many :book_images
  has_many :reviews
  belongs_to :category

  validates :title, presence: true
  validates :author, presence: true
  validates :category_id, presence: true
  validates :published_date, presence: true
  validates :total_page, presence: true

  accepts_nested_attributes_for :book_images, reject_if:
    lambda {|attribute| attribute[:image].blank?}, allow_destroy: true

  def self.search search
    if search
      where("title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
