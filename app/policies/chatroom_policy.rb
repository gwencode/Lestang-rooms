class ChatroomPolicy < ApplicationPolicy
  def show?
    user.admin || record.booking.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin
        scope.all
      else
        scope.joins(:booking).where(bookings: { user: user })
      end
    end
  end
end
