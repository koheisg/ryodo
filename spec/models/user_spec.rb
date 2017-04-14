require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }
  let(:user_with_params) { User.new(params) }

  describe '#validate' do

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
      let(:params) { {email: 'user001@example.com'} }
      it 'is invalid' do
        expect(user_with_params).to be_invalid
      end
    end

    context 'when given no email' do
      let(:params) { {username: 'user001'} }
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
