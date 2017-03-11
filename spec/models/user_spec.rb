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
    it 'can create its article through proper validation' do
      article = user.articles.build(title: "title")
      expect(article.save).to be_truthy
    end

    it 'cannot create its article when title is blank' do
      article = user.articles.build
      expect(article.save).to be_falsey
    end

    it 'cannot create its article when title is blank' do
      article = user.articles.build
      expect(article.save).to be_falsey
    end

    it 'can have many articles' do
      article1 = user.articles.build(title: "post1")
      article2 = user.articles.build(title: "post2")
      expect(article1.save).to be_truthy
      expect(article2.save).to be_truthy
    end
  end

  describe 'tags' do
    it 'can create its tag through proper validation' do
      tag = user.tags.build(name: "tag")
      expect(tag.save).to be_truthy
    end

    it 'cannot create its tag when name is blank' do
      tag = user.tags.build
      expect(tag.save).to be_falsey
    end

    it 'can have many tags' do
      tag1 = user.tags.build(name: "tag1")
      tag2 = user.tags.build(name: "tag2")
      expect(tag1.save).to be_truthy
      expect(tag2.save).to be_truthy
    end
  end

  describe 'repository' do
    it 'can have repository through proper validation' do
      repo = user.build_github_repository(name: "repo")
      expect(repo).to be_truthy
    end

    it 'can have repository through proper validation' do
      repo = user.build_github_repository
      expect(repo.save).to be_falsey
    end

    it 'will not have any repository when fails to build' do
      bad_repo = user.build_github_repository
      bad_repo.save
      expect(user.github_repository.user_id).to eq user.id
      expect(user.github_repository.name).to be_nil
    end
  end
end
