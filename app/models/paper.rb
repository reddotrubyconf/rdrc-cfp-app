# frozen_string_literal:true

class Paper < ApplicationRecord
  with_options unless: :draft? do
    validates :abstract, presence: true
  end
  validates :title, presence: true
  validates :status, presence: true

  belongs_to :user, inverse_of: :papers

  enum status: [:draft, :submitted, :accepted, :rejected, :withdrawn].freeze

  def editable?
    draft? || submitted?
  end
end
