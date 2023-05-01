class Admin::SeasonsController < ApplicationController
  before_action :set_room
  before_action :set_season, only: %i[edit update destroy]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    policy_scope(Season)
    @seasons = @room.seasons.order("start_date ASC")
  end

  def new
    @season = Season.new
    authorize @season
  end

  def create
    @season = Season.new(season_params)
    @season.room = @room
    authorize @season
    if @season.save
      @season.update(start_date: @season.start_date.change(hour: 14), end_date: @season.end_date.change(hour: 12))
      redirect_to admin_room_seasons_path, notice: "Condition ajoutée"
    else
      render :new, status: :unprocessable_entity, alert: @season.errors.messages.values.join(", ")
    end
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
    authorize @season
    @season.destroy
    redirect_to admin_room_seasons_path, notice: "Condition supprimée"
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
