require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user_email) { 'user@example.com' }
  let(:user_password) { '123456' }
  let!(:user) { create :user, email: user_email, password: user_password }

  context 'when user already signed in' do
    before { sign_in(user) }

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to redirect_to(tasks_url) }
    end

    describe 'POST #create' do
      subject { post :create }

      it { is_expected.to redirect_to(tasks_url) }
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy }

      it { is_expected.to redirect_to(new_session_url) }

      it 'sign out current user' do
        subject
        expect(controller.current_user).to be nil
      end
    end
  end

  context 'when user is not signed' do
    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to have_http_status(200) }
    end

    describe 'POST #create' do
      subject { post :create, params: { session: session_attrs } }

      context 'with valid attributes' do
        let(:session_attrs) { { email: user_email, password: user_password } }

        it 'sign in as created user' do
          subject
          expect(controller.current_user).to eq(User.last)
        end
      end

      context 'with invalid attributes' do
        let(:session_attrs) { { email: user_email, password: '' } }

        it { is_expected.to render_template(:new) }
      end
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy }

      it { is_expected.to redirect_to(new_session_url) }
    end
  end
end
