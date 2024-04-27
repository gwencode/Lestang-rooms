class Admin::UrlPicturesController < ApplicationController
  before_action :set_url_picture, only: %i[edit update]

  def edit
  end

  def update
    if @url_picture.update(url_picture_params)
      redirect_to admin_pictures_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def url_picture_params
    params.require(:url_picture).permit(:description, :url, :photo)
  end

  def set_url_picture
    @url_picture = UrlPicture.find(params[:id])
    authorize @url_picture
  end
end
