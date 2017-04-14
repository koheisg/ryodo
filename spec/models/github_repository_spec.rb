require 'rails_helper'

describe GithubRepository do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    let(:repo_with_params) { GithubRepository.new(params) }

    context 'when given the correct params' do
      let(:params) { {user: user, name: barely_long_name} }
      let(:barely_long_name) { Array.new(24){[*0..1].sample}.join }
      it 'is valid' do
        expect(repo_with_params).to be_valid
      end

      it 'is valid with name shorter than 24 words' do
        expect(repo_with_params).to be_valid
      end
    end

    context 'when given non-alphabetical name' do
      let(:params) { {user: user, name: japanese_name} }
      let(:japanese_name) { "レポジトリ" }
      it 'is invalid with name not in alphabets' do
        expect(repo_with_params).to be_invalid
      end
    end

    context 'when given name with any full-width char' do
      let(:params) { {user: user, name: fullwidth_num} }
      let(:fullwidth_num) { "００１" }
      it 'is invalid with name in full-width chars' do
        expect(repo_with_params).to be_invalid
      end
    end

    context 'when given long name' do
      let(:params) { {user: user, name: long_name} }
      let(:long_name) { Array.new(25){[*0..1].sample}.join }
      it 'is invalid with name longer than 24 words' do
        expect(repo_with_params).to be_invalid
      end
    end
  end
end
