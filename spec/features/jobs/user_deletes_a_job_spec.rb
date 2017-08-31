require 'rails_helper'

describe "User deletes existing job" do
  scenario "a user can delete a job" do
    company = create(:company)
    job = create(:job, company: company)

    visit company_jobs_path(company)

    within(".job_#{job.id}") do
      click_link "Delete"
    end

    expect(page).to have_content("Janitor was successfully deleted!")
  end
end
