class Request < ActiveRecord::Base
  belongs_to :user

  enum status: {"Approved": true, "Pending": false}

  validates :book_title, presence: true
  validates :book_author, presence: true
  validates :url, presence: true
  validates :status, inclusion: {in: statuses.keys}

  def self.search search
    if search
      where("book_title LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
