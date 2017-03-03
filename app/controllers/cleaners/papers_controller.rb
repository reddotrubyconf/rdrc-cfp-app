# frozen_string_literal: true

class Cleaners::PapersController < ApplicationController
  layout "cfp"

  before_action :authenticate!
  before_action :authorize_cleaner!

  # GET cleaners/papers
  def index
    @papers = Paper.where(status: [:submitted, :scrubbed])
  end

  # GET cleaners/papers/:id/edit
  def edit
    @paper = find_paper
  end

  # PATCH cleaners/papers/:id
  def update
    @paper = find_paper

    if @paper.update(paper_params)
      redirect_to cleaners_papers_path
    else
      flash[:error] = @paper.errors.full_messages.to_sentence.capitalize
      render :edit
    end
  end

  private

  def paper_params
    params.require(:paper).permit(:scrubbed_outline).merge(status: :scrubbed)
  end

  def find_paper
    Paper.find(params[:id])
  end
end
