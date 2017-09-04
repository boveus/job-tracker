require 'rails_helper'

describe Company do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
  end
  describe "Class methods" do
    it "calculates the average interest value of jobs for a company" do
        category = create(:category)
        company = create(:company)
        company2 = create(:company, name: 'company2')
        company3 = create(:company, name: 'company3')


        7.times { create(:job, company: company2, category: category, level_of_interest: 5) }
        3.times { create(:job, company: company3, category: category, level_of_interest: 10) }
        5.times { create(:job, company: company, category: category, level_of_interest: 5) }
        12.times { create(:job, company: company, category: category, level_of_interest: 10) }
        7.times { create(:job, company: company, category: category, level_of_interest: 5) }

        interest = Company.average_interest_of_jobs

        expect(interest["Umbrella Corp"].round(2)).to eq(7.5)
        expect(interest["company2"].round(2)).to eq(5.0)
        expect(interest["company3"].round(2)).to eq(10.0)
      end
    it "retrieves the top 3 companies based on level of interest" do
      category = create(:category)
      company = create(:company)
      company2 = create(:company, name: 'company2')
      company3 = create(:company, name: 'company3')


      7.times { create(:job, company: company2, category: category, level_of_interest: 5) }
      3.times { create(:job, company: company3, category: category, level_of_interest: 10) }
      5.times { create(:job, company: company, category: category, level_of_interest: 5) }
      12.times { create(:job, company: company, category: category, level_of_interest: 10) }
      7.times { create(:job, company: company, category: category, level_of_interest: 5) }

      top_three_companies = Company.top_three_by_average_imterest

      expect(top_three_companies.length).to eq(3)
      expect(top_three_companies.values[0]).to eq(10.0)
      expect(top_three_companies.values[1]).to eq(7.5)
      expect(top_three_companies.values[2]).to eq(5.0)
    end
  end
end
