class AdminPolicy < ApplicationPolicy
  def dashboard?
    user.admin
  end

  def slots?
    dashboard?
  end

  def seasons?
    dashboard?
  end

  def messages?
    dashboard?
  end

  def pictures?
    dashboard?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all if user&.admin
    end
  end

end
