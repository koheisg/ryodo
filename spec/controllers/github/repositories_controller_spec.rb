require 'rails_helper'

RSpec.describe Github::RepositoriesController, type: :controller do
  before do
    FactoryGirl.create :user
  end
  let(:user) { User.first }

  describe 'GET #create' do
    let(:user) { User.first }
    context 'when access token is valid' do
      it 'creates repository' do
        controller.session[:user_id] = user.id
        VCR.use_cassette('github_repository') do
          GithubAccessToken.create(user: user, access_token: 'a7b41a71c5903582f1e2e6d61cfc0fbd6130a12b')
          params = {
            github_repository: {
               name: 'Sample' }}
          get :create, params
          expect(user.github_repository).to be_truthy
        end
      end
    end
    context 'when access token is invalid' do
      it 'raises exception and does not save repository name' do
        VCR.use_cassette('github_repository_failure') do
          controller.session[:user_id] = user.id
          GithubAccessToken.create(user: user, access_token: 'fake token')
          params = {
            github_repository: {
               name: 'Sample' }}
          get :create, params
          expect(user.github_repository).to be_nil
          expect(response).to redirect_to me_edit_path
        end
      end
    end
    context 'when name is empty' do
      it 'renders :new' do
        VCR.use_cassette('github_repository_failure') do
          controller.session[:user_id] = user.id
          GithubAccessToken.create(user: user, access_token: 'fake token')
          params = {
            github_repository: {
               name: '' }}
          get :create, params
          expect(user.github_repository).to be_nil
          expect(response.code).to eq("200")
        end
      end
    end
  end
end
