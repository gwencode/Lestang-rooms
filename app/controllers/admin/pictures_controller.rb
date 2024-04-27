class Admin::PicturesController < ApplicationController
  before_action :set_picture, only: %i[edit update]

  def index
    @pictures = policy_scope(Picture)
    @pictures = @pictures.order(description: :asc)
    @url_pictures = policy_scope(UrlPicture)
    @rooms = policy_scope(Room)
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to admin_pictures_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:description, photos: [])
  end

  def set_picture
    @picture = Picture.find(params[:id])
    authorize @picture
  end
end
