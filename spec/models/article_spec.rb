require 'rails_helper'

describe Article do
  let(:article) { FactoryGirl.build :article }

  describe 'Article validation' do
    let(:article_with_no_params) { Article.new() }
    let(:article_with_no_title) { Article.new(user_id: 1) }
    let(:article_with_no_user_id) { Article.new(title: "Title") }
    let(:barely_long_title) { Array.new(50){[*0..1].sample}.join }
    let(:long_title) { Array.new(51){[*0..1].sample}.join }

    context 'passed the validation' do
      it 'saves the article' do
        expect(article.save).to be_truthy
      end

      it 'saves the article with title less than 51' do
        article_with_barely_long_title = Article.new(user_id: 1, title: barely_long_title)
        expect(article_with_barely_long_title.save).to be_truthy
      end
    end

    context 'did not pass the validation' do
      it 'fails to save the article with no params' do
        expect(article_with_no_params.save).to be_falsey
      end

      it 'fails to save the article with no title' do
        expect(article_with_no_title.save).to be_falsey
      end

      it 'fails to save the article with no user association' do
        expect(article_with_no_user_id.save).to be_falsey
      end

      it 'fails to save the article with title longer than 50' do
        article_with_long_title = Article.new(user_id: 1, title: long_title)
        expect(article_with_long_title.save).to be_falsey
      end
    end
  end
end
