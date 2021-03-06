require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:owner).class_name('User') }
  it { should belong_to(:creator).class_name('User') }
  it { should validate_presence_of(:title) }

  describe 'status state machine' do
    context 'when status = open' do
      let(:task) { build :task, status: 'open' }

      it 'could not be finished' do
        expect(task.can_finish_task?).to be false
      end

      it 'could be started' do
        expect(task.can_start_task?).to be true
      end
    end

    context 'when status = in_progress' do
      let(:task) { build :task, status: 'in_progress' }

      it 'could be finished' do
        expect(task.can_finish_task?).to be true
      end

      it 'could be opened' do
        expect(task.can_open_task?).to be true
      end
    end

    context 'when status = done' do
      let(:task) { build :task, status: 'done' }

      it 'could not be finished' do
        expect(task.can_open_task?).to be false
      end

      it 'could not be opened' do
        expect(task.can_start_task?).to be false
      end
    end
  end

  describe 'scope' do
    describe '.with_creator.with_owner' do
      let(:owner) { create :user }
      let(:creator) { create :user }
      let(:task) { create :task, owner: owner, creator: creator }

      subject { described_class.with_creator(creator.email).with_owner(owner.email) }

      it 'properly select record' do
        is_expected.to eq([task])
      end
    end
  end
end
