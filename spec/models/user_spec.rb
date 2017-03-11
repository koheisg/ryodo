require 'rails_helper'

describe User do
  user = FactoryGirl.build :user

  describe 'validation' do
    it 'is validate' do
      expect(user).to be_truthy
    end
    it 'is not validate when username and email are blank' do
      no_username_nor_email = User.new()
      expect(no_username_nor_email.save).to be_falsey
    end
    it 'is not validate when username is blank' do
      no_username = User.new(email: 'abc@d.e')
      expect(no_username.save).to be_falsey
    end
    it 'is not validate when email is blank' do
      no_email = User.new(username: 'kameda')
      expect(no_email.save).to be_falsey
    end
    it 'has id' do
      expect(user.id).to be_truthy
    end
  end

  describe 'articles' do
    it 'can create article associated with itself through proper validation' do
      user.save
      article = user.articles.build(title: "title")
      expect(article.save).to be_truthy
    end

    it 'cannot create article associated with itself when title is blank' do
      article = user.articles.build
      expect(article.save).to be_falsey
    end
  end
end
