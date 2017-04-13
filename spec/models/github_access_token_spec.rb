require 'rails_helper'

describe GithubAccessToken do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    let(:token_with_params) { GithubAccessToken.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, access_token: "token"} }
      it 'is valid' do
        expect(token_with_params).to be_valid
      end
    end

    context 'when given empty params' do
      let(:params) { {} }
      it 'is invalid' do
        expect(token_with_params).to be_invalid
      end
    end
  end
end
