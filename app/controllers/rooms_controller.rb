class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    @maison = Room.first
    @chambre = Room.last
    image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "Home", '*.{jpg,jpeg,png,gif}'))
    image_paths = image_files.map { |image_path| "Home/#{File.basename(image_path)}" }
    @two_first_image_paths = image_paths.first(2)
    last_image_paths = image_paths.drop(2)
    @last_two_image_paths = last_image_paths.each_slice(2).to_a
  end

  def show
    image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", '*.{jpg,jpeg,png,gif}'))
    @image_paths = image_files.map { |image_path| "#{@room.name}/#{File.basename(image_path)}" }
    @last_image_paths = @image_paths.drop(1)

    sleep_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", 'sleep', '*.{jpg,jpeg,png,gif}'))
    @sleep_image_paths = sleep_files.map { |image_path| "#{@room.name}/sleep/#{File.basename(image_path)}" }
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
