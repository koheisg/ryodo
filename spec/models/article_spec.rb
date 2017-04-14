require 'rails_helper'

describe Article do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    let(:article_with_params) { Article.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, title: barely_long_title} }
      let(:barely_long_title) { Array.new(50){[*0..1].sample}.join }
      it 'is valid' do
        expect(article_with_params).to be_valid
      end

      it 'is valid with title less than 51 words' do
        expect(article_with_params).to be_valid
      end

      it 'is valid with title less than 51 words' do
        expect(article_with_params).to be_valid
      end
    end

    context 'when given the empty params' do
      let(:params) { {} }
      it 'is invalid' do
        expect(article_with_params).to be_invalid
      end
    end

    context 'when given no title' do
    let(:params) { {user_id: 1} }
      it 'is invalid' do
        expect(article_with_params).to be_invalid
      end
    end

    context 'when given the wrong params' do
      let(:long_title) { Array.new(51){[*0..1].sample}.join }
      let(:params) { {user: user, title: long_title} }
      it 'is invalid with title longer than 50 words' do
        expect(article_with_params).to be_invalid
      end
    end

    context 'when given the wrong params' do
      let(:long_title) { Array.new(51){[*0..1].sample}.join }
      let(:params) { {user: user, title: long_title} }
      it 'is invalid with title longer than 50 words' do
        expect(article_with_params).to be_invalid
      end
    end
  end
end
