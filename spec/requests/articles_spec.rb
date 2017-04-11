require 'rails_helper'

RSpec.feature "Article", type: :feature do
  describe 'GET articles#show' do
    let(:user) { FactoryGirl.create :user }
    let(:article) { FactoryGirl.create :article }

    it 'shows article content' do
      visit article_path(article)
      expect(page).to have_text("Hello")
    end
  end
end
