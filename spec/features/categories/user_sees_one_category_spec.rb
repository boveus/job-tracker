require 'rails_helper'

describe "User sees a category" do
  scenario "a user sees a category" do
    create_list(:category, 3)
    company =  create(:company)
    category = create(:category, title: "SPORTS")
    job = create(:job, category: category, company: company)


    visit category_path(category)

    expect(page).to have_content("SPORTS")
    expect(page).to have_content(job.title)
  end

end
