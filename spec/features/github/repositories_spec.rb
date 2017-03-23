require 'rails_helper'

RSpec.feature "Markdowns", type: :feature do
  describe 'Github Repository' do
    let(:user) { User.create(email: "123@sample.com") }

    context 'when visit #new' do
      it 'is 200' do
        VCR.use_cassette('users_create') do
          page.set_rack_session(user_id: user.id)
          visit '/github/repositories/new'
          expect(page).to have_text('ブログを置くレポジトリを、あなたのGithubアカウント内に作成します')
        end
      end
    end
  end
end
