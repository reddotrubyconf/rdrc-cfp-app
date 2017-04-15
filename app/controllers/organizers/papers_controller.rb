# frozen_string_literal: true

class Organizers::PapersController < ApplicationController
  layout "cfp"

  before_action :authenticate!
  before_action :authorize_organizer!

  # GET organizers/papers
  def index
    @papers = Paper.scrubbed.includes(:reviews).sort_by { |p| -p.review_score }
  end

  # GET organizers/paper/:id
  def show
    @paper = find_paper
  end

  private

  def find_paper
    Paper.find(params[:id])
  end
end
