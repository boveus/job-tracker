# The user can visit /jobs?sort=location to view a list of the jobs sorted by city.
require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs in the correct order" do
    company = create(:company)
    category = create(:category)
    job1 = create(:job, company: company, category: category)
    job2 = create(:job, city: "Boston", title: "QA Analyst", company: company, category: category)

    visit all_jobs_path(sort: "location")

    expect(job2.title).to appear_before(job1.title)
  end
end
