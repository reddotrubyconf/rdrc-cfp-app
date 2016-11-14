# frozen_string_literal: true

FactoryGirl.define do
  factory :paper do
    user

    title "A New Hope"
    abstract "A long time ago in a galaxy far, far away ..."
    status Paper.statuses[:submitted]

    trait :invalid do
      title ""
    end
  end
end
