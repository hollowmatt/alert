class IssuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # def show?

  # end
end
