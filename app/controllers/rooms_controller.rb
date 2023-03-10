class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    @maison = Room.first
    @chambre = Room.last
  end

  def show
    image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", '*.{jpg,jpeg,png,gif,PNG}'))
    @image_paths = image_files.map { |image_path| "#{@room.name}/#{File.basename(image_path)}" }
    @last_image_paths = @image_paths.drop(1)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
