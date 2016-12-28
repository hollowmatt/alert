class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.platform.has_member?(user)
  end

  def create?
    writable?
  end

  def update?
    writable?
  end

  private
    def writable?
      user.try(:admin?) || record.platform.has_manager?(user) ||
        record.platform.has_editor?(user)
    end
end


