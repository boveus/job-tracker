require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    company = create(:company)
    category = create(:category)
    job = create(:job, company: company, category: category)

    visit company_job_path(company, job)

    expect(page).to have_content("Umbrella Corp")
    expect(page).to have_content("Janitor")
    expect(page).to have_content("1")
  end
end
