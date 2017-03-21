require 'rails_helper'

RSpec.describe Github::RepositoriesController, type: :controller do
  before do
    User.create(email: 'kamedashigeru@gmail.com')
  end

  describe 'GET #create' do
    let(:user) { User.first }
    it 'succeeds when code is valid' do
      VCR.use_cassette('github_authorize') do
        params = {
          code: '6bf6e3ee7beef8933569'}
        get :create, params
        expect(user.github_repository).to be_truthy
      end
    end
  end
end
