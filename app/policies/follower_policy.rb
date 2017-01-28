class FollowerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?
      scope.joins(:roles).where(roles: {user_id: user})
    end
  end

  def index?
    user.try(:admin?) 
  end

  def new?
    user.try(:admin?) 
  end

  def create?
  	user.try(:admin)
  end

  def destroy?
  	user.try(:admin)
  end
end