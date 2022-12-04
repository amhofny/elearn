require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  it { should belong_to(:course) }
  it { should belong_to(:user) }
end
