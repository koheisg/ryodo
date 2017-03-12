require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  describe '#validate' do
    let(:user_with_no_params) { User.new() }
    let(:user_with_no_username) { User.new(email: 'user001@example.com') }
    let(:user_with_no_email) { User.new(username: 'user001') }

    context 'when given the correct params' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'when given the wrong params' do
      it 'is invalid with no username and email' do
        expect(user_with_no_params).to be_invalid
      end

      it 'is invalid with no username' do
        expect(user_with_no_username).to be_invalid
      end

      it 'is invalid with no email' do
        expect(user_with_no_email).to be_invalid
      end
    end
  end
end
