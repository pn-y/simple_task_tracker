require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when user already signed in' do
    let(:user) { create :user }

    before { sign_in(user) }

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to redirect_to(tasks_url) }
    end

    describe 'POST #create' do
      subject { post :create }

      it { is_expected.to redirect_to(tasks_url) }
    end
  end

  context 'when user is not signed' do
    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to have_http_status(200) }
    end

    describe 'POST #create' do
      subject { post :create, params: { user: user_attrs } }

      context 'with valid attributes' do
        let(:user_attrs) { attributes_for(:user) }

        it { expect { subject }.to change(User, :count).by(1) }
        it { is_expected.to redirect_to(tasks_url) }

        it 'sign in as created user' do
          subject
          expect(controller.current_user).to eq(User.last)
        end
      end

      context 'with invalid attributes' do
        let(:user_attrs) { { email: '' } }

        it { is_expected.to render_template(:new) }
      end
    end
  end
end
