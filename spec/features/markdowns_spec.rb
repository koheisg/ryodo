require 'rails_helper'

RSpec.feature "Markdowns", type: :feature do
  describe 'Markdown Parse' do
    let(:user) { FactoryGirl.create(:user) }

    it 'parse article content as markdown' do
      Article.create(user: user, title: "Title", content: "# Hello", published: true)
      visit "/articles/1"
      expect(page).to have_text("Hello")
    end
  end

end
