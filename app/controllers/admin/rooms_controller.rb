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
      medium_guests: params[:medium_guests],
      night_price_medium_guests: params[:night_price_medium_guests],
      high_guests: params[:high_guests],
      night_price_high_guests: params[:night_price_high_guests],
      week_duration: params[:week_duration],
      week_reduction: params[:week_reduction],
      medium_duration: params[:medium_duration],
      medium_reduction: params[:medium_reduction],
      high_duration: params[:high_duration],
      high_reduction: params[:high_reduction],
      small_cleaning_duration: params[:small_cleaning_duration],
      small_cleaning_fee: params[:small_cleaning_fee],
      medium_cleaning_duration: params[:medium_cleaning_duration],
      medium_cleaning_fee: params[:medium_cleaning_fee],
      high_cleaning_duration: params[:high_cleaning_duration],
      high_cleaning_fee: params[:high_cleaning_fee]
    )

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
                                 :bathrooms,
                                 :min_nights,
                                 :max_nights,
                                 :available_days)
  end
end
