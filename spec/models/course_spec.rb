require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to(:author) }
  it { should have_many(:talents) }
  it { should validate_presence_of(:name) }
end
