class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.platform.roles.exists?(user_id: user)
  end
end
