# frozen_string_literal: true

class Paper < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

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

  belongs_to :user, inverse_of: :papers

  enum status:       [:draft, :submitted, :scrubbed, :accepted, :rejected, :withdrawn].freeze
  enum speaker_slot: [:lightning, :regular].freeze

  def editable?
    draft? || submitted?
  end
end
