class ChatroomPolicy < ApplicationPolicy
  def show?
    user.admin || record.booking.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
