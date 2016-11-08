# frozen_string_literal: true

class My::PapersController < ApplicationController
  before_action :authenticate!

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # POST /papers/create
  def create
    @paper = Paper.new(paper_params)

    if @paper.save
      redirect_to my_paper_path(@paper)
    else
      flash[:error] = @paper.errors.full_messages.to_sentence.capitalize
      render :new
    end
  end

  # GET /papers/:id
  def show
    @paper = find_paper
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :abstract)
  end

  def find_paper
    Paper.find(params[:id])
  end
end
