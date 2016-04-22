class Activity < PublicActivity::Activity
  has_many :likes

  class << self
    def current_user_activity owner, trackable
      self.where owner_id: owner, trackable_type: trackable
    end
  end
end
