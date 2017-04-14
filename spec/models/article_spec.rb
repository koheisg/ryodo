require 'rails_helper'

describe Article do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    subject { Article.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, title: "Title"} }
      it { is_expected.to be_valid }
    end

    context 'when given a title less than 51 words' do
      let(:params) { {user: user, title: barely_long_title} }
      let(:barely_long_title) { Array.new(50){[*0..1].sample}.join }
      it { is_expected.to be_valid }
    end

    context 'when given the empty params' do
      let(:params) { {} }
      it { is_expected.to be_invalid }
    end

    context 'when given no title' do
      let(:params) { {user_id: 1} }
      it { is_expected.to be_invalid }
    end

    context 'when given a title more than 50 words' do
      let(:long_title) { Array.new(51){[*0..1].sample}.join }
      let(:params) { {user: user, title: long_title} }
      it { is_expected.to be_invalid }
    end
  end
end
