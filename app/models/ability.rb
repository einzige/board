class Ability
  
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      unless user.new_record?
        can :manage, User do |usr|
          user == usr
        end
      end
    end
  end

end
