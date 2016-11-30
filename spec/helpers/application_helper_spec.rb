require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#options_for_users_select' do
    let!(:user_1) { create :user }
    let!(:user_2) { create :user }

    subject { options_for_users_select(user_1.email) }

    it do
      is_expected.
        to include("<option selected=\"selected\" value=\"#{user_1.email}\">#{user_1.email}</option>")
      is_expected.
        to include("<option value=\"#{user_2.email}\">#{user_2.email}</option>")
    end
  end

  describe '#options_for_status_select' do
    subject { options_for_status_select('open') }

    it do
      is_expected.to include('<option selected="selected" value="open">Open</option>')
      is_expected.to include('<option value="in_progress">In Progress</option>')
      is_expected.to include('<option value="done">Done</option>')
    end
  end

  describe '#generate_transitions_collection' do
    let(:task) { create :task, status: 'in_progress' }

    subject { generate_transitions_collection(task) }

    it do
      is_expected.to eq([[nil, 'In Progress'], [:open_task, 'Open'], [:finish_task, 'Done']])
    end
  end
end
