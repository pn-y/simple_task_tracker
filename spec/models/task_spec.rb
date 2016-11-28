require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:owner).class_name('User') }
  it { should belong_to(:creator).class_name('User') }
end
