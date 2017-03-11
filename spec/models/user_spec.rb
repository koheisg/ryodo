require 'rails_helper'

describe User do
  user = FactoryGirl.create :user

  describe 'validation' do
    it 'is validate' do
      expect(user).to be_truthy
    end
    it 'is not validate when username and email are blank' do
      no_name = User.new()
      expect(no_name.save).to be_falsey
    end
    it 'is not validate when username is blank' do
      no_name = User.new(email: 'abc@d.e')
      expect(no_name.save).to be_falsey
    end
    it 'is not validate when email is blank' do
      no_email = User.new(username: 'kameda')
      expect(no_email.save).to be_falsey
    end
    it 'has id' do
      expect(user.id).to be_truthy
    end
  end
end
