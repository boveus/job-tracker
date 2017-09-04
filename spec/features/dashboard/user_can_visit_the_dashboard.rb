require 'rails_helper'

describe "User sees the dashbooard" do
  scenario "a user visits the dashboard" do
    visit dashboard_path

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Dashboard")
  end
end
