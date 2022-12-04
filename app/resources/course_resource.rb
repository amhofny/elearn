class CourseResource < JSONAPI::Resource
  attributes :name

  has_one :author, foreign_key: :user_id
  has_many :talents
end
