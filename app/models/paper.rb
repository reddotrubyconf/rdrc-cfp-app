# frozen_string_literal:true

class Paper < ApplicationRecord
  validates :title, presence: true
  validates :abstract, presence: true
  validates :status, presence: true

  enum status: [:drafted, :submitted, :accepted, :rejected, :withdrawn].freeze
end
