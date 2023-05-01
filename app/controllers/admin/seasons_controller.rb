class Admin::SeasonsController < ApplicationController
  before_action :set_room

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    policy_scope(Season)
    @seasons = @room.seasons
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end
