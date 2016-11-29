require 'rails_helper'

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
    subject { post :create, params: { task: task_attrs } }

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

    subject { get :edit, params: { id: task.id } }

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

    subject { patch :update, params: { task: task_attrs, id: task.id } }

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

        describe 'status changing' do
          let(:task_attrs) { { status_event: 'start_task' } }

          it 'changes status' do
            subject
            expect(Task.find(task.id).status).to eq('in_progress')
          end
        end
      end

      context 'with invalid attributes' do
        let(:task_attrs) { { title: '' } }

        it { is_expected.to render_template(:edit) }

        describe 'status changing' do
          let(:task_attrs) { { status_event: 'random string' } }

          it 'do not changes status' do
            subject
            expect(Task.find(task.id).status).to eq('open')
          end
        end
      end
    end
  end
end
