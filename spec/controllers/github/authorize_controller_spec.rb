require 'rails_helper'

RSpec.describe ::Github::AuthorizeController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  describe 'GET #new' do
    it 'is 302' do
      controller.session[:user_id] = user.id
      get :new, {}
      expect(response.code).to eq("302")
    end
  end

  describe 'GET #create' do
    context 'when code is valid' do
      it 'saves access token' do
        VCR.use_cassette('github_authorize') do
          controller.session[:user_id] = user.id
          params = {
            code: 'de50fd448a43c8351a1d'}
          get :create, params
          expect(user.github_access_token).to be_truthy
        end
      end
    end
    context 'when code is invalid' do
      it 'fails to save access token' do
        VCR.use_cassette('github_authorize_failure') do
          controller.session[:user_id] = user.id
          params = {
            code: 'fake code'}
          get :create, params
          expect(user.github_access_token).to be_nil
        end
      end
    end
  end
end
