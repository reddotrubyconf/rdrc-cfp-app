# frozen_string_literal: true

FactoryGirl.define do
  factory :paper do
    user

    title        "A New Hope"
    abstract     "A long time ago in a galaxy far, far away ..."
    outline      "Possibly the best paper ever submitted."

    status       :submitted
    speaker_slot :regular

    trait :invalid do
      title ""
    end
  end
end
