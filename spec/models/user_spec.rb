require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  describe '#validation' do
    subject { User.new(params) }

    context 'when given the correct params' do
      let(:params) { {username: "ryodo001", email: "ryodo@example.com"} }
      it { is_expected.to be_valid }
    end

    context 'when given no params' do
      let(:params) { {} }
      it { is_expected.to be_invalid }
    end

    context 'when given no username' do
      let(:params) { {email: 'user001@example.com'} }
      it { is_expected.to be_invalid }
    end

    context 'when given no email' do
      let(:params) { {username: 'user001'} }
      it { is_expected.to be_invalid }
    end

    context 'when given no username' do
      let(:params) { {email: 'user001@example.com' } }
      it { is_expected.to be_invalid }
    end
  end

  # has_oneの関係にあるものは、新しく保存する時に更新されるのをテストしたいのだけれども、これはhas_oneそのもののテストだからいらないかな？
  describe 'saving repository through User' do
    let(:params1) { {name: "repo1"} }
    let(:params2) { {name: "repo2"} }

    context 'when user have Github repository' do
      it 'refresh to new repository' do
        repo = user.build_github_repository(params1)
        repo.save
        expect(user.github_repository.name).to eq params1[:name]
        repo = user.build_github_repository(params2)
        repo.save
        expect(user.github_repository.name).to eq params2[:name]
      end
    end
  end
end
