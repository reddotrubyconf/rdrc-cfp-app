FactoryGirl.define do
  sequence(:email) { |n| "anakin#{n}@thedarkside.com" }

  factory :user do
    name "Anakin Skywalker"
    email

    trait :invalid do
      name ""
    end
  end
end
