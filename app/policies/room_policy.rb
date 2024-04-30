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

  def edit_room_contents?
    user&.admin
  end

  def update_room_contents?
    edit_room_contents?
  end

  def edit_room_pictures?
    user&.admin
  end

  def update_room_pictures?
    edit_room_pictures?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
