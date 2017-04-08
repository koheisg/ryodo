require 'rails_helper'

RSpec.feature "Markdowns", type: :feature do
  describe 'Github Repository' do
    let(:user) { FactoryGirl.create(:user) }

    context 'when visit #new' do
      # feature specのセッション導入は現在調査中
      # it 'is 200' do
      #   VCR.use_cassette('users_create') do
      #     visit '/github/repositories/new'
      #     expect(page).to have_text('ブログを置くレポジトリを、あなたのGithubアカウント内に作成します')
      #   end
      # end
    end
  end
end
