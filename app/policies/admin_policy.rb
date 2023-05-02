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

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

end
