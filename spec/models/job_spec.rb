require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, and company" do
        company = Company.new(name: "Turing")
        category = create(:category)

        job = Job.create(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
    end
    it "belongs to a category" do
      category = create(:category)
      job = job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo", category: category)

      expect(job).to respond_to(:category)
    end
  end
  describe "class methods" do
    it "can sort jobs by city" do
      category = create(:category)
      company = create(:company)
      10.times { create(:job, company: company, category: category) }
      create(:job, company: company, category: category, city: 'Boston')

      expect(Job.sort_by_city.first.city).to eq('Boston')
    end
    it "can sort jobs by interest" do
      category = create(:category)
      company = create(:company)
      create(:job, company: company, category: category, level_of_interest: 10)
      create(:job, company: company, category: category, level_of_interest: 25)

      expect(Job.sort_by_interest.first.level_of_interest).to eq(25)


    end
    it "returns a count of jobs by level of interest" do
      category = create(:category)
      company = create(:company)
      12.times { create(:job, company: company, category: category, level_of_interest: 10 ) }
      7.times { create(:job, company: company, category: category, level_of_interest: 5 ) }

      count_by_level_of_interest = Job.count_by_level_of_interest

      expect(count_by_level_of_interest[10]).to eq(12)
      expect(count_by_level_of_interest[5]).to eq(7)

    end
    it "returns a count of jobs by location and provides a link to jobs in that location" do
      category = create(:category)
      company = create(:company)
      12.times { create(:job, company: company, category: category, city: "Boston" ) }
      7.times { create(:job, company: company, category: category, city: "Denver" ) }

      count_by_city = Job.count_by_city

      expect(count_by_city["Boston"]).to eq(12)
      expect(count_by_city["Denver"]).to eq(7)
    end
  end
end
