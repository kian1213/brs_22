class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
    else
      can :manage, Review
      can :read, Book
      can :read, User
    end
  end
end
