class RoomPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user&.admin
  end

  def destroy?
    user&.admin
  end

  def update_descriptions?
    user&.admin
  end

  def edit_room_contents?
    update_descriptions?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
