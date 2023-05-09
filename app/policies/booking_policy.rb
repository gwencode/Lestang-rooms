class BookingPolicy < ApplicationPolicy
  def show?
    user.admin
  end

  def update?
    user.admin
  end

  def edit?
    update?
  end

  def accept?
    user.admin
  end

  def decline?
    user.admin
  end

  def create?
    true
  end

  def destroy?
    user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
