FactoryBot.define do
  factory :user do
    name { Faker::Name.name }

    trait :author do
      author { true }
    end

    trait :talent do
      author { false }
    end

    factory :author_with_courses do
      author { true }
      authored_courses { [association(:course)] }
    end
  end
 end
