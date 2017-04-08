require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    FactoryGirl.create :user
  end

  let(:correct_params) { {code: '8e2bf871424da25ccfef'} }
  let(:wrong_params) { {code: 'fake code'} }

  describe 'GET #new' do
    it 'is 302' do
      get :new
      expect(response.code).to eq("302")
    end
  end

  describe 'GET #create' do
    context 'when code is valid' do
      it 'logs in' do
        VCR.use_cassette('users_create') do
          get :create, correct_params
          expect(response).to redirect_to articles_path
        end
      end
    end
    context 'when code is invalid' do
      it 'fails to log in' do
        VCR.use_cassette('users_login_failure') do
          get :create, wrong_params
          expect(response).to redirect_to root_path
        end
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
