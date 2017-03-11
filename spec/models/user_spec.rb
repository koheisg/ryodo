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

    it 'cannot have repository when name is blank' do
      repo = user.build_github_repository
      expect(repo.save).to be_falsey
    end

    it 'refresh to new repository when create its another' do
      repo = user.build_github_repository(name: "repo1")
      repo.save
      expect(user.github_repository.name).to eq 'repo1'
      repo = user.build_github_repository(name: "repo2")
      repo.save
      expect(user.github_repository.name).to eq 'repo2'
    end

    it 'will not have any repository when fails to build' do
      bad_repo = user.build_github_repository
      bad_repo.save
      expect(user.github_repository.user_id).to eq user.id
      expect(user.github_repository.name).to be_nil
    end
  end

  describe 'access token' do
    it 'can have access token' do
      token = user.build_github_access_token
      expect(user.github_access_token.save).to be_truthy
    end

    it 'refresh to new access token when create its another' do
      token = user.build_github_access_token(access_token: "abc", scope: "scope1", token_type: "A")
      token.save
      expect(user.github_access_token.access_token).to eq 'abc'
      expect(user.github_access_token.scope).to eq 'scope1'
      expect(user.github_access_token.token_type).to eq 'A'
      token = user.build_github_access_token(access_token: "def", scope: "scope2", token_type: "B")
      token.save
      expect(user.github_access_token.access_token).to eq 'def'
      expect(user.github_access_token.scope).to eq 'scope2'
      expect(user.github_access_token.token_type).to eq 'B'
    end
  end

  describe 'VCR' do
    it 'save response' do
      VCR.use_cassette("test01") do
        Net::HTTP.get_response(URI('http://localhost:3000/signup'))
        expect(response.body).to be_truthy
      end
    end
  end
end
