class User < ApplicationRecord
  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users

  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id,
           dependent: :restrict_with_error

  validates :name, presence: true

  scope :authors, -> { where(author: true) }
end
