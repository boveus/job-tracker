require 'rails_helper'

describe "User creates a new job comment" do
  scenario "a user can create a new comment on a job" do
    company = create(:company)
    category = create(:category)
    job = create(:job, company: company, category: category)

    visit company_job_path(company, job)

    fill_in "comment_content", with: "I hate this job"
    click_on 'Create Comment'

    expect(current_path).to eq("/companies/#{company.id}/jobs/#{job.id}")
    expect(page).to have_content("#{job.comments.first.content}")
  end
end
