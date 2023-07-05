class ErrorPolicy < ApplicationPolicy
  def not_found?
    true
  end

  def unacceptable?
    true
  end

  def internal_server_error?
    true
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
