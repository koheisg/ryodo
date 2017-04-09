require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #new' do
    before do
      controller.session[:user_id] = id
      get :new
    end

    context "when user is already logged into the service" do
      let(:id) { user.id }
      it 'is redirects back' do
        expect(response.code).to eq("302")
      end
    end
    context "when user is not logged into the service" do
      let(:id) { user.id }
      it 'is redirects to Github with redirection to /github/authorize/callback/signup' do
        aggregate_failures 'tests responses' do
          expect(response.code).to eq("302")
          expect(response).to redirect_to("https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT_ID']}&redirect_uri=http://localhost:3000/github/authorize/callback/signup&scope=user%20repo")
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
      let(:cassette_name) { 'users_create' }
      let(:params) { {code: '8e2bf871424da25ccfef'} }
      it 'creates new user' do
        aggregate_failures 'tests responses' do
          expect(User.first).to be_truthy
          expect(response).to redirect_to articles_path
        end
      end
      context 'when code is invalid' do
        let(:cassette_name) { 'users_create_failure' }
        let(:params) { {code: 'fake code'} }
        it 'fails to create new user' do
          aggregate_failures 'tests responses' do
            expect(User.first).to be_nil
            expect(response).to redirect_to root_path
          end
        end
      end
    end
  end
end
