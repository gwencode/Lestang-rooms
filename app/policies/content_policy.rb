class ContentPolicy < ApplicationPolicy
  def update?
    user&.admin
  end

  def edit?
    update?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
