class Category < ActiveRecord::Base
  has_many :books

  validates :name, presence: true
  validates :description, presence: true

  def self.search search
    if search
      where("name LIKE ?", "%#{search}%")
    else
      all
    end
  end
end
