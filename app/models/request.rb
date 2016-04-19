class Request < ActiveRecord::Base
  belongs_to :user

  validates :book_title, presence: true
  validates :book_author, presence: true
  validates :url, presence: true

  enum status: {"Approved": true, "Pending": false}

  def self.search search
    if search
      where("book_title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
