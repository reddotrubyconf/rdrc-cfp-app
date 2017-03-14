# frozen_string_literal: true

class Conference < ApplicationRecord
  validates :name,          presence: true
  validates :cfp_closes_at, presence: true

  def self.latest
    order(cfp_closes_at: :desc).first
  end

  def cfp_closed?
    Time.zone.now > cfp_closes_at
  end

  def cfp_open?
    !cfp_closed?
  end
end
