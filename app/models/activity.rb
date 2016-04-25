class Activity < PublicActivity::Activity
  has_many :likes

  class << self
    def current_user_activity owner
      self.where owner_id: owner
    end
  end
end
