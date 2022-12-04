class AuthorResource < JSONAPI::Resource
  model_name 'User'
  attributes :name

  has_many :courses, relation_name: :authored_courses

  before_create :set_author

  def self.records(options = {})
    User.authors
  end

  def set_author
    @model.author = true
  end
end
