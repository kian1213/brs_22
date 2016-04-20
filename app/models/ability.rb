class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
    else
      can :manage, Review
      can :manage, Request
      can :manage, Comment
      can :read, Book
      can :read, User
    end
  end
end
