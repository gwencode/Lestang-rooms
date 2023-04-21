class Admin::RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update]
  before_action :authorize_admin, only: :index

  def index
    policy_scope(Room)
    @maison = Room.first
    @chambre = Room.last
  end

  def show
  end

  def edit
  end

  def update
    @room.update(room_params)

    redirect_to admin_room_path(@room)
  end

  private

  def authorize_admin
    authorize :admin, :dashboard?
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:description,
                                 :max_guests,
                                 :price_per_day,
                                 :arrival_hour,
                                 :departure_hour,
                                 :bedrooms,
                                 :beds,
                                 :bathrooms)
  end
end
