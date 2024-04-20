class Admin::RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update edit_descriptions update_descriptions]
  before_action :authorize_admin, only: %i[index show]

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
    if @room.room_price.update(
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
        redirect_to admin_room_path(@room), notice: "Logement modifié"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = @room.room_price.errors.full_messages.join('. ')
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_descriptions
  end

  def update_descriptions
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "Logement modifié"
    else
      render :edit_descriptions, status: :unprocessable_entity
    end
  end

  private

  def authorize_admin
    authorize :admin, :dashboard?
  end

  def set_room
    @room = Room.friendly.find(params[:id])
    authorize @room
  end

  def room_params
    params.require(:room).permit(:name,
                                 :description,
                                 :max_guests,
                                 :arrival_hour,
                                 :departure_hour,
                                 :bedrooms,
                                 :beds,
                                 :bathrooms,
                                 :min_nights,
                                 :max_nights,
                                 :available_days,
                                 :default_available_slots,
                                 :bank_fees,
                                 :caution,
                                 :description_title,
                                 :detailed_short_description,
                                 :detailed_long_description
                                )
  end
end
