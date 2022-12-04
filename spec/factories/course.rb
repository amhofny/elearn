FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    author { create(:user, :author) }
  end
 end
