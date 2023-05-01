class Admin::SlotsController < ApplicationController
  before_action :set_room
  before_action :set_slot, only: %i[edit update destroy]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    policy_scope(Slot)
    @slots = @room.slots.order("start_date ASC")
  end

  def new
    @slot = Slot.new
    authorize @slot
  end

  def create
    @slot = Slot.new(slot_params)
    @slot.room = @room
    authorize @slot
    if @slot.save
      @slot.update(start_date: @slot.start_date.change(hour: 14), end_date: @slot.end_date.change(hour: 12))
      redirect_to admin_room_slots_path, notice: "Créneau ajouté"
    else
      render :new, status: :unprocessable_entity, alert: @slot.errors.messages.values.join(", ")
    end
  end

  def edit
    authorize @slot
  end

  def update
    authorize @slot
    if @slot.update(slot_params)
      redirect_to admin_room_slots_path, notice: "Créneau modifié"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @slot
    @slot.destroy
    redirect_to admin_room_slots_path, notice: "Créneau supprimé"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def slot_params
    params.require(:slot).permit(:start_date, :end_date, :available)
  end

  def set_slot
    @slot = Slot.find(params[:id])
  end
end
