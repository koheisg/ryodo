require 'rails_helper'

describe GithubRepository do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    subject { GithubRepository.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, name: "repo"} }
      it { is_expected.to be_valid }
    end

    context 'when given a name less than 25 words' do
      let(:params) { {user: user, name: barely_long_name} }
      let(:barely_long_name) { Array.new(24){[*0..1].sample}.join }
      it { is_expected.to be_valid }
    end

    context 'when given non-alphabetical name' do
      let(:params) { {user: user, name: japanese_name} }
      let(:japanese_name) { "レポジトリ" }
      it { is_expected.to be_invalid }
    end

    context 'when given name with any full-width char' do
      let(:params) { {user: user, name: fullwidth_num} }
      let(:fullwidth_num) { "００１" }
      it { is_expected.to be_invalid }
    end

    context 'when given a name more than 25 words' do
      let(:params) { {user: user, name: long_name} }
      let(:long_name) { Array.new(25){[*0..1].sample}.join }
      it { is_expected.to be_invalid }
    end
  end
end
