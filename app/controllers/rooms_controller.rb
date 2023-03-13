class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    @maison = Room.first
    @chambre = Room.last
  end

  def show
    @name = @room.name
    @max_guests = @room.max_guests
    @price_per_day = @room.price_per_day
    @arrival_hour = @room.arrival_hour
    @departure_hour = @room.departure_hour
    @bedrooms = @room.bedrooms
    @beds = @room.beds
    @bathrooms = @room.bathrooms
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
