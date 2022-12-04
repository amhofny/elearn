class TalentResource < JSONAPI::Resource
  model_name 'User'
  attributes :name

  has_many :courses
end
