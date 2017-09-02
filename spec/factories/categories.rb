FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| "Cool Job#{n}" }
  end
end
