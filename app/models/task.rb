class Task < ApplicationRecord
  belongs_to :creator, class_name: User
  belongs_to :owner, optional: true, class_name: User
end
