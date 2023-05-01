class Admin::SeasonsController < ApplicationController
  before_action :set_room
  before_action :set_season, only: %i[edit update destroy]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    policy_scope(Season)
    @seasons = @room.seasons
  end

  def new
  end

  def create
  end

  def edit
    authorize @season
  end

  def update
    authorize @season
    if @season.update(season_params)
      redirect_to admin_room_seasons_path, notice: "Condition modifiée"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_season
    @season = Season.find(params[:id])
  end

  def season_params
    params.require(:season).permit(:start_date, :end_date, :min_nights)
  end
end
