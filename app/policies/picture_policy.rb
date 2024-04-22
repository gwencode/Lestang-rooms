class PicturePolicy < ApplicationPolicy
  def new?
    user.admin
  end

  def create?
    new?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
