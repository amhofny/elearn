FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    author { create(:user, :author) }
    talents { create_list(:user, 1, :talent) }
  end
 end
