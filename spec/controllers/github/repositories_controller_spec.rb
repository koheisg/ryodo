require 'rails_helper'

RSpec.describe Github::RepositoriesController, type: :controller do
  before do
    User.create(email: 'kamedashigeru@gmail.com')
  end
  let(:user) { User.first }
  let(:session) { {user_id: user.id} }

  describe 'GET #create' do
    let(:user) { User.first }
    context 'when access token is valid' do
      it 'creates repository' do
        VCR.use_cassette('github_repository') do
          GithubAccessToken.create(user: user, access_token: 'a7b41a71c5903582f1e2e6d61cfc0fbd6130a12b')
          params = {
            github_repository: {
               name: 'Sample' }}
          get :create, params, session
          expect(user.github_repository).to be_truthy
        end
      end
    end
  end
end
