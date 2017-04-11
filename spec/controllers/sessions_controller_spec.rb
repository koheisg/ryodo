require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { FactoryGirl.create :user }

  describe 'GET #new' do
    before do
      controller.session[:user_id] = id
      get :new
    end

    context "when user is already logged into the service" do
      let(:id) { user.id }
      it 'is redirects back to articles_path' do
        aggregate_failures 'tests responses' do
          expect(response.code).to eq("302")
          expect(response).to redirect_to articles_path
        end
      end
    end
    context "when user is not logged into the service" do
      let(:id) {}
      it 'is redirects to Github with redirection to /github/authorize/callback/login' do
        aggregate_failures 'tests responses' do
          expect(response.code).to eq("302")
          expect(response).to redirect_to("https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:3000/github/authorize/callback/login&scope=user%20repo")
        end
      end
    end
  end

  describe 'GET #create' do
    before do
      VCR.use_cassette(cassette_name) do
        get :create, params
      end
    end

    context 'when code is valid' do
      let(:params) { {code: '8e2bf871424da25ccfef'} }
      let(:cassette_name) { 'users_create' }
      it 'logs into the service' do
        expect(response).to redirect_to articles_path
      end
    end
    context 'when code is invalid' do
      let(:params) { {code: 'fake code'} }
      let(:cassette_name) { 'users_login_failure' }
      it 'fails to log into the service' do
        expect(response).to redirect_to root_path
      end
    end
  end
  describe 'GET #destroy' do
    it 'deletes session user_id and logs out the service' do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end
