class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  class << self
    def current_like activity_id, user_id
      self.where activity_id: activity_id, user_id: user_id
    end

    def check_if_included? activity_id, user_id
      like = self.where activity_id: activity_id, user_id: user_id
      !like.first.nil?
    end
  end
end
