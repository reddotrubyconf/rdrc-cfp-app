# frozen_string_literal: true

class Paper < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user, inverse_of: :papers

  has_many :reviews, inverse_of: :paper

  with_options unless: :draft? do
    validates :abstract, presence: true
    validates :outline,  presence: true
  end
  with_options if: :scrubbed? do
    validates :scrubbed_outline, presence: true
  end
  validates :title,        presence: true
  validates :status,       presence: true
  validates :speaker_slot, presence: true

  enum status:       [:draft, :submitted, :scrubbed, :accepted, :rejected, :withdrawn].freeze
  enum speaker_slot: [:lightning, :regular].freeze

  def editable?
    draft? || submitted?
  end

  def review_by(user)
    reviews.find_by(user: user) || NoReview.new
  end

  def review_score
    return 0 if reviews.none?

    (reviews.sum(:score) / reviews.count).round(2)
  end

  def review_score_diff
    return 0 if reviews.none?

    (review_score - reviews.minimum(:score)).round(2)
  end
end
