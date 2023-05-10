class Admin::UsersController < ApplicationController
  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    users = policy_scope(User).where(admin: false)
    @users = filter_users(users).order("first_name ASC")
  end

  def filter_users(users)
    case params[:filter]
    when "with-booking"
      users.joins(:bookings).where("bookings.id IS NOT NULL").group("users.id").having("COUNT(bookings.id) > 0")
    when "no-booking"
      users.left_joins(:bookings).group("users.id").having("COUNT(bookings.id) = 0")
    else
      users
    end
  end
end
