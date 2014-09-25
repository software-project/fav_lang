FactoryGirl.define do
  factory :user do
    sequence(:name) { |i| "user_#{i}" }
  end
end
