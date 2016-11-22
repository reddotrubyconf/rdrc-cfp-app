# frozen_string_literal: true

FactoryGirl.define do
  factory :paper do
    user

    title        "A New Hope"
    abstract     "A long time ago in a galaxy far, far away ..."

    status       :submitted
    speaker_slot :regular

    trait :invalid do
      title ""
    end
  end
end
