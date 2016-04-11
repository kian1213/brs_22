class Book < ActiveRecord::Base
  has_many :book_images
  has_many :reviews
  belongs_to :category
end
