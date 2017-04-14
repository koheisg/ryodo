require 'rails_helper'

describe GithubAccessToken do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    subject { GithubAccessToken.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, access_token: "token"} }
      it { is_expected.to be_valid }
    end

    context 'when given empty params' do
      let(:params) { {} }
      it { is_expected.to be_invalid }
    end
  end
end
