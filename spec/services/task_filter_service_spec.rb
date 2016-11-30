require 'rails_helper'

RSpec.describe TaskFilterService do
  describe '#resolve' do
    let(:initial_relation) { Task }
    let(:user_1) { create :user }
    let(:user_2) { create :user }
    let(:task_title) { 'Some title' }
    let(:task_status) { 'in_progress' }
    let(:task) { create :task, owner: user_1, creator: user_2, title: task_title, status: task_status }
    let(:task_1) { create :task, owner: (create :user), creator: user_2, title: task_title, status: task_status }
    let(:task_2) { create :task, owner: user_1, creator: (create :user), title: task_title, status: task_status }
    let(:task_3) { create :task, owner: user_1, creator: user_2, title: 'Stringz', status: task_status }
    let(:task_4) { create :task, owner: user_1, creator: user_2, title: task_title, status: 'open' }
    let(:params) do
      {
        owner: user_1.email,
        creator: user_2.email,
        title: task_title.split(' ').first,
        status: task_status
      }
    end

    subject { described_class.new(params, initial_relation).resolve }

    it 'correctly returns filtered tasks' do
      is_expected.to eq([task])
    end
  end
end
