class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    @maison = Room.first
    @chambre = Room.last
  end

  def show
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
