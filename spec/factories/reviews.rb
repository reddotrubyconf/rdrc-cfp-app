# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    user
    paper

    score 3

    trait :invalid do
      score 0
    end
  end
end
