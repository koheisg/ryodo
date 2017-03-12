require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  describe '#validate' do
    let(:user_with_params) { User.new(params) }

    context 'when given the correct params' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'when given no params' do
      let(:params) { {} }
      it 'is invalid' do
        expect(user_with_params).to be_invalid
      end
    end

    context 'when given no username' do
      let(:params) { {email: 'user001@example.com' } }
      it 'is invalid' do
        expect(user_with_params).to be_invalid
      end
    end

    context 'when given no email' do
      let(:params) { {username: 'user001' } }
      it 'is invalid' do
        expect(user_with_params).to be_invalid
      end
    end
  end
end
