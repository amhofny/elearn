class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_many :course_users, dependent: :destroy
  has_many :talents, through: :course_users, source: :user

  validates :name, presence: true
end
