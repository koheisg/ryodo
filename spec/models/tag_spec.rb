require 'rails_helper'

describe Tag do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    subject { Tag.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, name: "tag"} }
      it { is_expected.to be_valid }
    end

    context 'when given a name more than 20 words' do
      let(:params) { {user: user, name: barely_long_name} }
      let(:barely_long_name) { Array.new(20){[*0..1].sample}.join }
      it { is_expected.to be_valid }
    end

    context 'when given the empty params' do
      let(:params) { {} }
      it { is_expected.to be_invalid }
    end

    context 'when given no name' do
      let(:params) { {user: user} }
      it { is_expected.to be_invalid }
    end

    context 'when given a name more than 20 words' do
      let(:params) { {user: user, name: long_name} }
      let(:long_name) { Array.new(21){[*0..1].sample}.join }
      it { is_expected.to be_invalid }
    end
  end
end
