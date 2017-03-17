# frozen_string_literal: true

class Review < ApplicationRecord
  SCORES = (1..5).freeze

  belongs_to :paper, inverse_of: :reviews
  belongs_to :user,  inverse_of: :reviews

  validates :score, numericality: { only_integer: true,
                                    greater_than_or_equal_to: SCORES.min,
                                    less_than_or_equal_to: SCORES.max }

  def self.scores
    SCORES
  end
end

class NoReview
  def score
    "-"
  end

  def comment
    ""
  end
end
