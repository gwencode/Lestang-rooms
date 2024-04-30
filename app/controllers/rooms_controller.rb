class RoomsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_room, only: [:show]
  before_action :set_index_contents, only: [:index]

  add_breadcrumb "Accueil", :root_path

  def index
    policy_scope(Room)
    @maison = Room.first
    @chambre = Room.last
    @reviews = Review.all

    @header_picture = Picture.find_by(name: "header")

    @home_images = Picture.find_by(name: "home")
    @first_two_home_images = @home_images.photos.first(2)
    last_home_images = @home_images.photos.last(@home_images.photos.count - 2)
    @last_two_home_images = last_home_images.each_slice(2).to_a

    # gallery_files = Dir.glob(Rails.root.join('app', 'assets', 'images', "home", 'gallery', '*.{jpg,jpeg,png,PNG,gif}'))
    # @gallery_images = gallery_files.map { |image_path| "home/gallery/#{File.basename(image_path)}" }
    @gallery_images = Picture.find_by(name: "home-gallery")
  end

  def show
    authorize @room

    gallery_files = Dir.glob(Rails.root.join('app', 'assets', 'images', @room.name.to_s, 'gallery', '*.{jpg,jpeg,png,gif}'))
    @gallery_images = gallery_files.map { |image_path| "#{@room.name}/gallery/#{File.basename(image_path)}" }

    sleep_files = Dir.glob(Rails.root.join('app', 'assets', 'images', @room.name.to_s, 'sleep', '*.{jpg,jpeg,png,gif}'))
    @sleep_images = sleep_files.map { |image_path| "#{@room.name}/sleep/#{File.basename(image_path)}" }
    # Security in case there are more images than expected in the folder
    @sleep_images = @room == Room.first ? @sleep_images.first(4) : @sleep_images.first(2)
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

    add_breadcrumb @room.name, room_path(@room)
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

  def set_index_contents
    @home_title_content = Content.find_by(name: "home_title")
    @introduction_description_content = Content.find_by(name: "introduction_description")
    @subtitle_home_title_content = Content.find_by(name: "subtitle_home_title")
    @subtitle_home_description_content = Content.find_by(name: "subtitle_home_description")
  end
end
