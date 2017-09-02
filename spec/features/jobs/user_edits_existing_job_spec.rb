require 'rails_helper'

describe "User edits an existing job" do
  scenario "a user can edit a job" do
    company = create(:company)
    category = create(:category)
    job = create(:job, company: company, category: category)


    visit edit_company_job_path(company, job)

    fill_in "job[title]", with: "Security guard"

    click_button "Update"
    # binding.pry
    expect(current_path).to eq("/companies/#{company.id}/jobs/#{Job.last.id}")
    expect(page).to have_content("Security guard")
    expect(page).to_not have_content("Janitor")
  end
end
