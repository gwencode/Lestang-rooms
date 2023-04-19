class BookingPolicy < ApplicationPolicy
  def index?
    user.admin
  end

  def show?
    user.admin
  end

  def update?
    user.admin
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all if user.admin
    end
  end
end
