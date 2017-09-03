require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = Company.create!(name: "ESPN")
    category = create(:category)
    company = create(:company)
    create(:job, company: company, category: category)

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("Umbrella Corp")
    expect(page).to have_content("Janitor")
  end
end
