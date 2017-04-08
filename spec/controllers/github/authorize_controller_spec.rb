require 'rails_helper'

RSpec.describe Github::AuthorizeController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #new' do
    context 'when user is logged in' do
      it 'accesses to github' do
        controller.session[:user_id] = user.id
        get :new
        aggregate_failures 'test responses' do
          expect(response.code).to eq("302")
          expect(response).to redirect_to("https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&scope=user%20repo")
        end
      end
    end
    context 'when user is not logged in' do
      it 'redirects to login_path' do
        get :new
        aggregate_failures 'test responses' do
          expect(response.code).to eq('302')
          expect(response).to redirect_to(login_path)
        end
      end
    end
  end

  describe 'GET #create' do
    before do
      VCR.use_cassette(cassette_name) do
        controller.session[:user_id] = user.id
        get :create, params
      end
    end

    context 'when code is valid' do
      let(:params) { {code: 'de50fd448a43c8351a1d'} }
      let(:cassette_name) { 'github_authorize' }
      it 'saves access token' do
        expect(user.github_access_token).to be_truthy
      end
    end

    context 'when code is invalid' do
      let(:params) { {code: 'fake code'} }
      let(:cassette_name) { 'github_authorize_failure' }
      it 'fails to save access token' do
        expect(user.github_access_token).to be_nil
      end
    end
  end
end
