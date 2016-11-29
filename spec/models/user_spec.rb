require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:created_tasks).class_name('Task').with_foreign_key(:creator_id) }
  it { should have_many(:owned_tasks).class_name('Task').with_foreign_key(:owner_id) }

  it { should allow_value('@').for(:email) }
  it { should_not allow_value('email').for(:email) }
end
