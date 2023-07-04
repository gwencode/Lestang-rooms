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

    @nights = 1
    @guests = 1
    @min_nights = 1
    @arrival = Date.today
    @departure = Date.today
    @max_nights = @room.max_nights.positive? ? @room.max_nights : 9999

    if params[:nights].present?
      @nights = params[:nights].to_i
      @guests = params[:guests].to_i
      arrival = create_date_from_date_string(params[:arrival].to_s)
      departure = create_date_from_date_string(params[:departure].to_s)
      @min_nights = check_seasons(arrival, departure)[:min_nights]
      @season_start = check_seasons(arrival, departure)[:start]
      @season_end = check_seasons(arrival, departure)[:end]
      render partial: 'prices', locals: {
        room: @room, nights: @nights,
        guests: @guests, min_nights: @min_nights,
        season_start: @season_start, season_end: @season_end,
        max_nights: @max_nights
      }
    end
  end

  private

  def set_room
    @room = Room.friendly.find(params[:id])
  end

  def create_date_from_date_string(date)
    date_array = date.split("-")
    Date.new(date_array[0].to_i, date_array[1].to_i, date_array[2].to_i)
  end

  def check_seasons(arrival, departure)
    @room.seasons.each do |season|
      season_start = Date.new(season.start_date.year, season.start_date.month, season.start_date.day)
      season_end = Date.new(season.end_date.year, season.end_date.month, season.end_date.day)
      if season_start <= arrival && season_end >= departure
        return { min_nights: season.min_nights, start: season_start, end: season_end }
      end
    end
    return { min_nights: @room.min_nights, start: nil, end: nil }
  end
end
