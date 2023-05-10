class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    users = policy_scope(User).where(admin: false)
    @users = filter_users(users).order("first_name ASC")

    if params[:query].present?
      sql_subquery = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = @users.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    authorize @user

    @bookings = @user.bookings.order("arrival DESC")
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "Utilisateur modifié"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
