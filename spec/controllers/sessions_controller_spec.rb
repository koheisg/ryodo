require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    User.create(email: 'kamedashigeru@gmail.com')
  end

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
          params = {
            code: '8e2bf871424da25ccfef'}
          get :create, params
          expect(response).to redirect_to articles_path
        end
      end
    end
  end
end
