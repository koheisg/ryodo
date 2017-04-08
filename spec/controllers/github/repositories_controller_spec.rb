require 'rails_helper'

RSpec.describe Github::RepositoriesController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #new' do
    context 'when user is logged in' do
      it 'is 200' do
        controller.session[:user_id] = user.id
        get :new
        expect(response.code).to eq('200')
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
        user.create_github_access_token(access_token: access_token)
        controller.session[:user_id] = user.id
        get :create, params
      end
    end

    context 'when access token is valid' do
      let(:params) { {github_repository: { name: 'Sample' }} }
      let(:cassette_name) { 'github_repository' }
      let(:access_token) { 'a7b41a71c5903582f1e2e6d61cfc0fbd6130a12b' }
      it 'creates repository' do
        expect(user.github_repository).to be_truthy
      end
    end

    context 'when access token is invalid' do
      let(:params) { {github_repository: { name: 'Sample' }} }
      let(:cassette_name) { 'github_repository_failure' }
      let(:access_token) { 'fake token' }
      it 'raises exception and does not save repository name' do
        aggregate_failures 'test responses' do
          expect(user.github_repository).to be_nil
          expect(response).to redirect_to me_edit_path
        end
      end
    end

    context 'when name is empty' do
      let(:params) { {github_repository: { name: '' }} }
      let(:cassette_name) { 'github_repository_failure' }
      let(:access_token) { 'fake token' }
      it 'renders :new' do
        aggregate_failures 'test responses' do
          expect(user.github_repository).to be_nil
          expect(response.code).to eq("200")
        end
      end
    end
  end
end
