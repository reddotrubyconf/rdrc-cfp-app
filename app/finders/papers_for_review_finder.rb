# frozen_string_literal: true

class PapersForReviewFinder
  def initialize(user)
    @user = user
  end

  def reviewed
    @reviewed_papers ||= Paper.scrubbed.left_joins(:reviews).merge(Review.where(user: user))
  end

  def unreviewed
    @unreviewed_papers ||= Paper.scrubbed.where.not(id: reviewed.select(:id))
  end

  private

  attr_reader :user
end
