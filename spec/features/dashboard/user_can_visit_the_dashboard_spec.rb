require 'rails_helper'

describe "User sees the dashbooard" do
  scenario "a user visits the dashboard" do
    company = create(:company)
    category = create(:category)
    job1 = create(:job, title: "job1", company: company, category: category, level_of_interest: 15)
    job2 = create(:job, title: "job2", company: company, category: category, level_of_interest: 19)
    job3 = create(:job, title: "job3", company: company, category: category, level_of_interest: 48)

    visit dashboard_path

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Dashboard")
  end
end
