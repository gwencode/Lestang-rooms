class AdminPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def dashboard?
    user.admin
  end

  def slots?
    dashboard?
  end

  def messages?
    dashboard?
  end
end
