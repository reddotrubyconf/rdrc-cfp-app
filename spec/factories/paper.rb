# frozen_string_literal: true

FactoryGirl.define do
  factory :paper do
    title "A New Hope"
    abstract "A long time ago in a galaxy far, far away ..."
    status Paper.statuses[:drafted]

    trait :invalid do
      title ""
    end
  end
end
