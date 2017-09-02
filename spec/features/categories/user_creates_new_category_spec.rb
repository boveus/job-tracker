require 'rails_helper'

describe "User creates a new category" do
  scenario "a user can create a new category" do
    visit new_category_path

    fill_in "category[title]", with: "Cool Job"

    click_on 'Create'

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("#{Category.first.title}")
  end
end
