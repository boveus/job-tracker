require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs for a specific company" do
    company = create(:company)
    category = create(:category)
    job = create(:job, company: company, category: category)
    job = create(:job, title: "QA Analyst", company: company, category: category)

    visit company_path(company)

    expect(page).to have_content("Umbrella Corp")
    expect(page).to have_content("Janitor")
    expect(page).to have_content("QA Analyst")
  end
end
