require 'rails_helper'

describe Tag do
  let(:articletag) { FactoryGirl.build :article_tag }
  let(:articletag_with_params) { ArticleTag.new(params) }
  let(:tag) { FactoryGirl.build :tag }

  describe '#validation' do
    context 'when given the correct params' do
      it 'is valid' do
        expect(articletag).to be_valid
      end
    end

    context 'when given only tag' do
      let(:params) { {tag: tag} }
      it 'is valid' do
        expect(articletag_with_params).to be_valid
      end
    end

    context 'when given params with no tag' do
      let(:params) { {article_id: 1} }
      it 'is invalid' do
        expect(articletag_with_params).to be_invalid
      end
    end
  end
end
