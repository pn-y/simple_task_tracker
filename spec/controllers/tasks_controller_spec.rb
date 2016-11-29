require 'rails_helper'
include AuthenticationHelper

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }

  describe 'GET #index' do
    subject { get :index }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      it { is_expected.to have_http_status(200) }
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      it { is_expected.to have_http_status(200) }
    end
  end

  describe 'task #create' do
    subject { post :create, task: task_attrs }

    let(:task_attrs) { attributes_for(:task) }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      context 'with valid attributes' do
        it { is_expected.to redirect_to(tasks_url) }

        it { expect { subject }.to change(Task, :count) }

        it 'creates task with current signed in user as creator' do
          subject
          expect(Task.last.creator).to eq(user)
        end
      end

      context 'with invalid attributes' do
        let(:task_attrs) { { title: '' } }

        it { is_expected.to render_template(:new) }
      end
    end
  end

  describe 'GET #edit' do
    let(:task) { create :task }

    subject { get :edit, id: task.id }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      it { is_expected.to have_http_status(200) }
    end
  end

  describe 'PATCH #update' do
    let(:task) { create :task }
    let(:new_task_title) { 'new title' }
    let(:task_attrs) { { title: new_task_title } }

    subject { patch :update, id: task.id, task: task_attrs }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      context 'with valid attributes' do
        it { is_expected.to redirect_to(tasks_url) }

        it 'updates task' do
          subject
          expect(Task.find(task.id).title).to eq(new_task_title)
        end
      end

      context 'with invalid attributes' do
        let(:task_attrs) { { title: '' } }

        it { is_expected.to render_template(:edit) }
      end
    end
  end
end
