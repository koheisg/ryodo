require 'rails_helper'

describe Tag do
  let(:articletag) { FactoryGirl.build :article_tag }
  let(:article) { Article.first }
  let(:tag) { Tag.first }

  context 'when passed the validation' do
    it 'saves the articletag' do
      expect(articletag.save).to be_truthy
    end

    it 'calls the belonging article' do
      articletag.save
      article = articletag.article
      expect(article.title).to eq "Title"
      expect(article.content).to eq "This is the content."
    end

    it 'calls the belonging tag' do
      articletag.save
      tag = articletag.tag
      expect(tag.name).to eq "Tag1"
    end

    it 'shows the through relation calling from article' do
      articletag.save
      tag = article.tags.first
      expect(tag.name).to eq "Tag1"
    end

    it 'shows the through relation calling from tag' do
      articletag.save
      article = tag.articles.first
      expect(article.title).to eq "Title"
      expect(article.content).to eq "This is the content."
    end
  end

  context 'when did not pass the validation' do
    let(:articletag_with_no_article) { ArticleTag.new(tag_id: 1) }
    let(:articletag_with_no_tag) { ArticleTag.new(article_id: 1) }

    it 'fails to save the articletag with no article_id' do
      expect(articletag_with_no_article.save).to be_falsey
    end

    it 'fails to save the articletag with no tag_id' do
      expect(articletag_with_no_tag.save).to be_falsey
    end
  end

  context 'when tag belonged to many articles' do
    let(:articles) { FactoryGirl.create_list(:article, 2) }
    let(:tag) { FactoryGirl.create :tag }
    let(:articletag_1) { tag.article_tags.build(article_id: 1) }
    let(:articletag_2) { tag.article_tags.build(article_id: 2) }

    it 'calls the belonging articles' do
      articletag_1.save
      articletag_2.save
      # 何故か失敗する（空が返る）
      expect(tag.articles.length).to eq 2
    end
  end

  context 'when article belonged to many tags' do
    let(:article) { FactoryGirl.create :article }
    let(:tag) { FactoryGirl.create_list(:tag, 2) }
    let(:articletag_1) { article.article_tags.build(tag_id: 1) }
    let(:articletag_2) { article.article_tags.build(tag_id: 2) }

    it 'calls the belonging tags' do
      articletag_1.save
      articletag_2.save
      # 何故か失敗する（こっちはarticletagのセーブにも失敗している）
      expect(article.tags.length).to eq 2
    end
  end
end
