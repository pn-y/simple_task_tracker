class User < ApplicationRecord
  has_secure_password

  has_many :owned_tasks, class_name: Task, foreign_key: :owner_id
  has_many :created_tasks, class_name: Task, foreign_key: :creator_id

  validates :email, uniqueness: true, format: { with: /@/ }
end
