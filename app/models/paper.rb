# frozen_string_literal:true

class Paper < ApplicationRecord
  with_options unless: :draft? do
    validates :abstract, presence: true
    validates :outline,  presence: true
  end
  validates :title,        presence: true
  validates :status,       presence: true
  validates :speaker_slot, presence: true

  belongs_to :user, inverse_of: :papers

  enum status:       [:draft, :submitted, :accepted, :rejected, :withdrawn].freeze
  enum speaker_slot: [:lightning, :regular].freeze

  def editable?
    draft? || submitted?
  end
end
