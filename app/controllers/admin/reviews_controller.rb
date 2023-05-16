class Admin::ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]

  def index
    unless current_user.admin
      flash[:alert] = "Accès non autorisé."
      redirect_to(root_path)
    end
    @reviews = policy_scope(Review).order("created_at ASC")
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    if @review.save
      redirect_to admin_reviews_path, notice: "Avis ajouté"
    else
      alert = @review.errors.full_messages.join(". ")
      @reviews = policy_scope(Review).order("created_at ASC")
      @review = Review.new
      redirect_to admin_reviews_path, alert: alert
    end
  end

  def update
    authorize @review

    if @review.update(review_params)
      redirect_to admin_reviews_path, notice: "Avis modifié"
    else
      alert = @review.errors.full_messages.join(". ")
      @reviews = policy_scope(Review).order("created_at ASC")
      @review = Review.new
      redirect_to admin_reviews_path, alert: alert
    end
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to admin_reviews_path, notice: "L'avis a bien été supprimé"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:room_id, :author, :content)
  end
end
