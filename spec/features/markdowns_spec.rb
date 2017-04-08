require 'rails_helper'

RSpec.feature "Markdowns", type: :feature do
  describe 'Markdown Parse' do
    let(:user) { FactoryGirl.create :user }
    let(:article) { FactoryGirl.create :article }

    it 'parse article content as markdown' do
      visit article_path(article)
      expect(page).to have_text("Hello")
    end
  end
end
