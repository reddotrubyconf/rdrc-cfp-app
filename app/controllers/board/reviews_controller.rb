# frozen_string_literal: true

class Board::ReviewsController < ApplicationController
  layout "cfp"

  before_action :authenticate!
  before_action :authorize_reviewer!

  # GET board/paper/:id/reviews/new
  def new
    @paper  = find_paper
    @review = find_review
  end

  # post board/papers/:id/reviews
  def create
    @paper  = find_paper
    @review = find_review

    if @review.update(review_params)
      redirect_to board_papers_path
    else
      flash[:error] = @review.errors.full_messages.to_sentence.capitalize
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:paper_id, :score, :comments).merge(user: current_user)
  end

  def find_paper
    Paper.find(params[:paper_id])
  end

  def find_review
    find_paper.reviews.find_or_initialize_by(user: current_user)
  end
end
