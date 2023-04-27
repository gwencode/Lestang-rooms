class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]

  def index
    policy_scope(Room)
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
    authorize @room

    gallery_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", 'gallery', '*.{jpg,jpeg,png,PNG,gif}'))
    @gallery_images = gallery_files.map { |image_path| "#{@room.name}/gallery/#{File.basename(image_path)}" }

    sleep_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "#{@room.name}", 'sleep', '*.{jpg,jpeg,png,PNG,gif}'))
    @sleep_images = sleep_files.map { |image_path| "#{@room.name}/sleep/#{File.basename(image_path)}" }

    @booking = Booking.new(room: @room)
    @dates_disabled = @room.dates_disabled

    if params[:nights].present?
      @nights = params[:nights].to_i
      render partial: 'prices', locals: { room: @room, nights: @nights }
      # respond_to do |format|
      #   format.json { render json: { nights: @nights } }
      # end
    else
      @nights = 0
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
