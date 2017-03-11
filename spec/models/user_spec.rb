require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build :user }
  let(:user_with_no_params) { User.new() }
  let(:user_with_no_username) { User.new(email: 'user001@example.com') }
  let(:user_with_no_email) { User.new(username: 'user001') }

  describe 'validation' do
    it 'is validate' do
      expect(user).to be_truthy
    end

    it 'is not validate when username and email are blank' do
      expect(user_with_no_params.save).to be_falsey
    end

    it 'is not validate when username is blank' do
      expect(user_with_no_username.save).to be_falsey
    end

    it 'is not validate when email is blank' do
      expect(user_with_no_email.save).to be_falsey
    end
  end

  describe 'articles' do
    let(:article_with_title) { user.articles.build(title: "title") }
    let(:article_with_no_title) { user.articles.build }
    let(:params1) { { title: "post1" } }
    let(:params2) { { title: "post2" } }

    it 'can create its article through proper validation' do
      expect(article_with_title.save).to be_truthy
    end

    it 'cannot create its article when title is blank' do
      expect(article_with_no_title.save).to be_falsey
    end

    it 'can have many articles' do
      article1 = user.articles.build(params1)
      article2 = user.articles.build(params2)
      expect(article1.save).to be_truthy
      expect(article2.save).to be_truthy
    end
  end

  describe 'tags' do
    let(:tag_with_name) { user.tags.build(name: "tag") }
    let(:tag_with_no_name) { user.tags.build }
    let(:params1) { { name: "tag1" } }
    let(:params2) { { name: "tag2" } }

    it 'can create its tag through proper validation' do
      expect(tag_with_name.save).to be_truthy
    end

    it 'cannot create its tag when name is blank' do
      expect(tag_with_no_name.save).to be_falsey
    end

    it 'can have many tags' do
      tag1 = user.tags.build(params1)
      tag2 = user.tags.build(params2)
      expect(tag1.save).to be_truthy
      expect(tag2.save).to be_truthy
    end
  end

  describe 'repository' do
    let(:repo_with_name) { user.build_github_repository(name: "repo") }
    let(:repo_with_no_name) { user.build_github_repository }
    let(:params1) { { name: "repo1" } }
    let(:params2) { { name: "repo2" } }

    it 'can have repository through proper validation' do
      expect(repo_with_name).to be_truthy
    end

    it 'cannot have repository when name is blank' do
      expect(repo_with_no_name.save).to be_falsey
    end

    it 'refresh to new repository when create its another' do
      repo = user.build_github_repository(params1)
      repo.save
      expect(user.github_repository.name).to eq params1[:name]
      repo = user.build_github_repository(params2)
      repo.save
      expect(user.github_repository.name).to eq params2[:name]
    end

    it 'will not have no repository name when fails to build' do
      repo_with_no_name.save
      expect(user.github_repository.name).to be_nil
    end
  end

  describe 'access token' do
    let(:token) { user.build_github_access_token }
    let(:params1) { {
      access_token: "abc",
      scope: "scope1",
      token_type: "A" }
    }
    let(:params2) { {
      access_token: "def",
      scope: "scope2",
      token_type: "B" }
    }
    it 'can have access token' do
      token.save
      expect(user.github_access_token.save).to be_truthy
    end

    it 'refresh to new access token when create its another' do
      token = user.build_github_access_token(params1)
      token.save
      expect(user.github_access_token.access_token).to eq params1[:access_token]
      expect(user.github_access_token.scope).to eq params1[:scope]
      expect(user.github_access_token.token_type).to eq params1[:token_type]
      token = user.build_github_access_token(params2)
      token.save
      expect(user.github_access_token.access_token).to eq params2[:access_token]
      expect(user.github_access_token.scope).to eq params2[:scope]
      expect(user.github_access_token.token_type).to eq params2[:token_type]
    end
  end
end
