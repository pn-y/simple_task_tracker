class Task < ApplicationRecord
  belongs_to :creator, class_name: User
  belongs_to :owner, optional: true, class_name: User
  belongs_to :creator, class_name: User, optional: false
  belongs_to :owner, class_name: User, optional: false

  validates :title, presence: true

  state_machine :status, initial: :open do
    event :start_task do
      transition open: :in_progress
    end

    event :open_task do
      transition in_progress: :open
    end

    event :finish_task do
      transition in_progress: :done
    end
  end
end
