require 'rails_helper'

feature 'Github Authorization' do
  scenario "User Github Authorization" do
    visit login_path
    expect(page).to have_content ''
  end
end
