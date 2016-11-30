class Task < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title, against: :title

  belongs_to :creator, class_name: User, optional: false
  belongs_to :owner, class_name: User, optional: false

  validates :title, presence: true

  scope :with_status, ->(status) { status.present? && where(status: status) }
  scope :with_creator, (lambda do |creator|
    creator.present? &&
    joins('inner join "users" as "creators" on "tasks"."creator_id" = "creators"."id"').
    where(creators: { email: creator })
  end)
  scope :with_owner, ->(owner) { owner.present? && joins(:owner).where(users: { email: owner }) }
  scope :with_title, ->(title) { title.present? && search_by_title(title) }

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
