require 'rails_helper'

describe "User creates a new job comment" do
  scenario "a user can create a new comment on a job" do
    company = create(:company)
    category = create(:category)
    job = create(:job, company: company, category: category)

    visit company_job_path(company, job)

    fill_in "category[title]", with: "Cool Job"

    click_on 'Create'

    expect(current_path).to eq("/categories/#{Category.last.id}")
    expect(page).to have_content("#{Category.first.title}")
  end
end
