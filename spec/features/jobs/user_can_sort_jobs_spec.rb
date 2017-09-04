# The user can visit /jobs?sort=location to view a list of the jobs sorted by city.
require 'rails_helper'

describe "User sees all jobs" do
  scenario "a user sees all the jobs sorted by city" do
    company = create(:company)
    category = create(:category)
    job1 = create(:job, company: company, category: category)
    job2 = create(:job, city: "Boston", title: "QA Analyst", company: company, category: category)

    visit all_jobs_path(sort: "location")

    expect(job2.title).to appear_before(job1.title)
  end
  scenario "a user sees all the jobs sorted by level of interest" do
    company = create(:company)
    category = create(:category)
    job1 = create(:job, title: "job1", company: company, category: category, level_of_interest: 15)
    job2 = create(:job, title: "job2", company: company, category: category, level_of_interest: 19)
    job3 = create(:job, title: "job3", company: company, category: category, level_of_interest: 48)

    visit all_jobs_path(sort: "interest")

    expect(job3.title).to appear_before(job2.title)
    expect(job2.title).to appear_before(job1.title)
  end
end
