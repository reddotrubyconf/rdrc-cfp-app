# frozen_string_literal: true

FactoryGirl.define do
  factory :conference do
    name "Pod Race"

    cfp_closes_at { 1.day.from_now }

    trait :open_for_cfp do
      cfp_closes_at { 1.day.from_now }
    end

    trait :closed_for_cfp do
      cfp_closes_at { 2.days.ago }
    end
  end
end
