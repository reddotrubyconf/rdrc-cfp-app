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

    trait :scrubbed do
      status           :scrubbed
      scrubbed_outline "Possibly the *second* best paper ever submitted."
    end

    trait :with_review do
      after(:create) do |paper|
        create_list :review, 1, paper: paper
      end
    end
  end
end
