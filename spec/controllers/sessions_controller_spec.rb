require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'is 302' do
      get :new
      expect(response.code).to eq("302")
    end
  end

  describe 'GET #create' do
    before do
      FactoryGirl.create :user
      VCR.use_cassette(cassette_name) do
        get :create, params
      end
    end

    context 'when code is valid' do
      let(:params) { {code: '8e2bf871424da25ccfef'} }
      let(:cassette_name) { 'users_create' }
      it 'logs in' do
        expect(response).to redirect_to articles_path
      end
    end

    context 'when code is invalid' do
      let(:params) { {code: 'fake code'} }
      let(:cassette_name) { 'users_login_failure' }
      it 'fails to log in' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #destroy' do
    it 'deletes session user_id' do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end
