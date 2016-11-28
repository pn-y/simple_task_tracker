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
    let(:task_attrs) { attributes_for(:task) }
    subject { post :create, task: task_attrs }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      it { is_expected.to have_http_status(200) }
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
    let(:task_attrs) { {} }

    subject { patch :update, id: task.id, task: task_attrs }

    context 'when no current user' do
      it { is_expected.to redirect_to(new_session_url) }
    end

    context 'when current user' do
      before { sign_in(user) }

      it { is_expected.to have_http_status(200) }
    end
  end
end
