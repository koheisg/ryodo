require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build :user }
  let(:user_with_no_params) { User.new() }
  let(:user_with_no_username) { User.new(email: 'user001@example.com') }
  let(:user_with_no_email) { User.new(username: 'user001') }

  describe 'User validation' do
    context 'when passed the validation' do
      it 'is saved' do
        expect(user.save).to be_truthy
      end
    end

    context 'when did not pass the validation' do
      it 'fails to save with no username and email' do
        expect(user_with_no_params.save).to be_falsey
      end

      it 'fails to save with no username' do
        expect(user_with_no_username.save).to be_falsey
      end

      it 'fails to save with no email' do
        expect(user_with_no_email.save).to be_falsey
      end
    end
  end

  describe 'saving articles through User' do
    let(:article_with_title) { user.articles.build(title: "title") }
    let(:article_with_no_title) { user.articles.build }
    let(:params1) { { title: "post1" } }
    let(:params2) { { title: "post2" } }

    context 'when passed the validation' do
      it 'saves its article' do
        expect(article_with_title.save).to be_truthy
      end

      it 'saves multiple articles' do
        article1 = user.articles.build(params1)
        article2 = user.articles.build(params2)
        expect(article1.save).to be_truthy
        expect(article2.save).to be_truthy
      end
    end

    context 'when did not pass the validation' do
      it 'fails to save the article with no title' do
        expect(article_with_no_title.save).to be_falsey
      end
    end
  end

  describe 'saving tags through User' do
    let(:tag_with_name) { user.tags.build(name: "tag") }
    let(:tag_with_no_name) { user.tags.build }
    let(:params1) { { name: "tag1" } }
    let(:params2) { { name: "tag2" } }

    context 'when passed the validation' do
      it 'saves its tag' do
        expect(tag_with_name.save).to be_truthy
      end
      it 'saves multiple tags' do
        tag1 = user.tags.build(params1)
        tag2 = user.tags.build(params2)
        expect(tag1.save).to be_truthy
        expect(tag2.save).to be_truthy
      end
    end

    context 'when did not pass the validation' do
      it 'fails to save with no name' do
        expect(tag_with_no_name.save).to be_falsey
      end
    end
  end

  describe 'saving repository through User' do
    let(:repo_with_name) { user.build_github_repository(name: "repo") }
    let(:repo_with_no_name) { user.build_github_repository }
    let(:params1) { { name: "repo1" } }
    let(:params2) { { name: "repo2" } }

    context 'when params have name' do
      it 'saves its repo' do
        expect(repo_with_name).to be_truthy
      end

      it 'refresh to new repo when creates its another' do
        repo = user.build_github_repository(params1)
        repo.save
        expect(user.github_repository.name).to eq params1[:name]
        repo = user.build_github_repository(params2)
        repo.save
        expect(user.github_repository.name).to eq params2[:name]
      end
    end

    context 'saving when params have no name' do
      it 'fails to save its repo' do
        expect(repo_with_no_name.save).to be_falsey
      end

      it 'will not have any repository name' do
        repo_with_no_name.save
        expect(user.github_repository.name).to be_nil
      end
    end
  end

  describe 'saving access token through User' do
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

    context 'when params are filled' do
      it 'saves its access token' do
        expect(token.save).to be_truthy
      end

      it 'refreshes to new access token when creates its another' do
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
end
