require 'rails_helper'

RSpec.describe Github::AuthorizeController, type: :controller do
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
    let(:user) { User.first }
    it 'succeeds when code is valid' do
      VCR.use_cassette('github_authorize') do
        params = {
          code: '6bf6e3ee7beef8933569'}
        get :create, params
        expect(user.github_access_token).to be_truthy
      end
    end
  end
end
