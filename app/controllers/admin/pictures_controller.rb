class Admin::PicturesController < ApplicationController
  def new
    @picture = Picture.new
    authorize @picture
  end

  def create
    @picture = Picture.new(picture_params)
    authorize @picture
    if @picture.save
      redirect_to admin_pictures_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:name, photos: [])
  end
end
