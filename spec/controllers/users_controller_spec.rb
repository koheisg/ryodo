require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
      it 'creates new user' do
        VCR.use_cassette('users_create') do
          get :create, correct_params
          expect(User.first).to be_truthy
          expect(response).to redirect_to articles_path
        end
      end
      context 'when code is invalid' do
        it 'fails to create new user' do
          VCR.use_cassette('users_create_failure') do
            get :create, wrong_params
            expect(User.first).to be_nil
            expect(response).to redirect_to root_path
          end
        end
      end
    end
  end
end
