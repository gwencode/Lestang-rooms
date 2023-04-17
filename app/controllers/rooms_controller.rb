class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    @maison = Room.first
    @chambre = Room.last
    @reviews = Review.all
    image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "home", '*.{jpg,jpeg,png,gif}'))
    @home_images = image_files.map { |image_path| "home/#{File.basename(image_path)}" }
    @first_two_home_images = @home_images.first(2)
    last_home_images = @home_images.drop(2)
    @last_two_home_images = last_home_images.each_slice(2).to_a

    gallery_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "home", 'gallery', '*.{jpg,jpeg,png,PNG,gif}'))
    @gallery_images = gallery_files.map { |image_path| "home/gallery/#{File.basename(image_path)}" }
  end

  def show
    image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", '*.{jpg,jpeg,png,gif}'))
    @image_paths = image_files.map { |image_path| "#{@room.name}/#{File.basename(image_path)}" }
    @last_image_paths = @image_paths.drop(1)

    sleep_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", 'sleep', '*.{jpg,jpeg,png,PNG,gif}'))
    @sleep_images = sleep_files.map { |image_path| "#{@room.name}/sleep/#{File.basename(image_path)}" }

    @booking = Booking.new(room: @room)
    @dates_disabled = @room.dates_disabled
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
