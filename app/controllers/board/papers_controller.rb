# frozen_string_literal: true

class Board::PapersController < ApplicationController
  layout "cfp"

  before_action :authenticate!
  before_action :authorize_reviewer!

  # GET board/papers
  def index
    @papers = PapersForReviewFinder.new(current_user)
  end

  private

  def find_paper
    Paper.find(params[:id])
  end

  def find_review
    find_paper.reviews.find_or_initialize_by(user: current_user)
  end
end
