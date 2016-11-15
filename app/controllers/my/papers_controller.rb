# frozen_string_literal: true

class My::PapersController < ApplicationController
  before_action :authenticate!

  # GET /papers
  def index
    @papers = current_user.papers.all
  end

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # POST /papers/create
  def create
    @paper = current_user.papers.build(paper_params)

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

  # GET /papers/:id/edit
  def edit
    @paper = find_paper
  end

  # PATCH /papers/:id
  def update
    @paper = find_paper

    if @paper.update(paper_params)
      redirect_to my_paper_path(@paper)
    else
      flash[:error] = @paper.errors.full_messages.to_sentence.capitalize
      render :edit
    end
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :abstract).merge(status: paper_status)
  end

  def paper_status
    if params[:draft]
      :draft
    elsif params[:withdraw]
      :withdrawn
    else
      :submitted
    end
  end

  def find_paper
    current_user.papers.find(params[:id])
  end
end
