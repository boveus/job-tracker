require 'rails_helper'

describe "User sees all categories" do
  scenario "a user sees all the categories" do
    create_list(:category, 3)
    create(:category, title: "SPORTS")

    visit categories_path

    expect(page).to have_content("SPORTS")
  end

end
