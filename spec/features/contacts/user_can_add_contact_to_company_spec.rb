require 'rails_helper'

describe "User creates a new job comment" do
  scenario "a user can create a new contact for a company" do
    company = create(:company)

    visit company_path(company)

    # save_and_open_page

    fill_in "contact[name]", with: "Penelope Santorini"
    fill_in "contact[position]", with: "Hiring Manager"
    fill_in "contact[email]", with: "penelope@wooo.com"

    click_on "Create Contact"

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("#{Contact.last.name}")
    expect(page).to have_content("#{Contact.last.position}")
    expect(page).to have_content("#{Contact.last.email}")
  end
end
