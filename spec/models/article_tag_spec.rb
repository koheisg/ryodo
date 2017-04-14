require 'rails_helper'

describe ArticleTag do
  # ここでユーザー生成時にcreateメソッドを使用するとバグが発生する
  # ActiveRecord::RecordInvalid: Validation failed: Email has already been taken
  # 現在はbuildにしている
  let(:user) { FactoryGirl.build :user }
  let(:article) { FactoryGirl.create :article }
  let(:tag) { FactoryGirl.create :tag, user: user }

  describe '#validation' do
    subject { ArticleTag.new(params) }

    context 'when given the correct params' do
      let(:params) { {article: article, tag: tag} }
      it { is_expected.to be_valid }
    end

    context 'when given only tag' do
      let(:params) { {tag: tag} }
      it { is_expected.to be_valid }
    end

    context 'when given params with no tag' do
      let(:params) { {article: article} }
      it { is_expected.to be_invalid }
    end
  end
end
