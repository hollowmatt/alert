class DistlistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil? || !user.admin?
      return scope.all if user.admin?
    end
  end

  def index?
    user.try(:admin?) 
  end

  def new?
    user.try(:admin?) 
  end

  def create?
    writable?
  end

  def show?
    user.try(:admin)
  end

  def update?
    user.try(:admin)
  end

  def destroy?
    user.try(:admin)
  end

  private
    def writable?
      user.try(:admin?)
    end
end