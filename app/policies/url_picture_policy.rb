class UrlPicturePolicy < ApplicationPolicy
  def edit?
    user&.admin
  end

  def update?
    edit?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all if user&.admin
    end
  end
end
