class BookingPolicy < ApplicationPolicy
  def show?
    user.admin || record.user == user
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

  def payment?
    record.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
