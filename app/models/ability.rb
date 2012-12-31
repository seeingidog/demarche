class Ability
  include CanCan::Ability

  #https://github.com/EppO/rolify/wiki/Tutorial
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
    end    
  end
end
