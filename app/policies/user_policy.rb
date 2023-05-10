class UserPolicy < ApplicationPolicy
  def show?
    user.admin
  end

  def update?
    user.admin || user == record
  end

  def edit?
    update?
  end

  def destroy?
    user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all if user.admin
    end
  end
end
