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

  def index
    @pictures = policy_scope(Picture)
    @pictures = @pictures.order(description: :asc)
  end

  def edit
    @picture = Picture.find(params[:id])
    authorize @picture
  end

  def update
    @picture = Picture.find(params[:id])
    authorize @picture
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
end
