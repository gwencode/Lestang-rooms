class Admin::RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update]
  before_action :authorize_admin, only: %i[index show]

  def index
    policy_scope(Room)
    @maison = Room.first
    @chambre = Room.last
  end

  def show
    authorize @room
  end

  def edit
    authorize @room
  end

  def update
    authorize @room
    @room.room_price.update(
      night_price: params[:night_price],
      night_price_seven_guests: params[:night_price_seven_guests].to_i,
      night_price_eight_guests: params[:night_price_eight_guests].to_i,
      week_reduction: params[:week_reduction],
      cleaning_fee: params[:cleaning_fee])

    if @room.update(room_params)
      redirect_to admin_room_path(@room)
    else
      render :edit, status: :unprocessable_entity
    end
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
                                 :arrival_hour,
                                 :departure_hour,
                                 :bedrooms,
                                 :beds,
                                 :bathrooms)
  end
end
