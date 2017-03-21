require 'rails_helper'

RSpec.describe ::Github::AuthorizeController, type: :controller do
  before do
    User.create(email: 'kamedashigeru@gmail.com')
  end
  let(:user) { User.first }
  let(:session) { {user_id: user.id} }

  describe 'GET #new' do
    it 'is 302' do
      get :new, {}, session
      expect(response.code).to eq("302")
    end
  end

  describe 'GET #create' do
    context 'when code is valid' do
      it 'saves access token' do
        VCR.use_cassette('github_authorize') do
          params = {
            code: 'de50fd448a43c8351a1d'}
          get :create, params, session
          expect(user.github_access_token).to be_truthy
        end
      end
    end
  end
end
