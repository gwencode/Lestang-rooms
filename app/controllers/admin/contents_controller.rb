class Admin::ContentsController < ApplicationController
  before_action :set_content, only: [:edit, :update]

  def edit
  end

  def update
    if @content.update(content_params)
      redirect_to root_path, notice: "Contenu modifié"
    else
      errors = @content.errors.messages
      if errors.has_key?(:html)
        flash.now[:alert] = "Le contenu #{errors[:html].first}"
      else
        flash.now[:alert] = "Erreur inconnue"
      end
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_content
    @content = Content.find(params[:id])
    authorize @content
  end

  def content_params
    params.require(:content).permit(:html)
  end
end
