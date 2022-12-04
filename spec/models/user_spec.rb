require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:course_users) }
  it { should have_many(:courses) }
  it { should have_many(:authored_courses) }
  it { should validate_presence_of(:name) }
  it "should select authors" do
    authors = User.where(author: true)
    expect(User.authors.count).to eq authors.count
  end
end
