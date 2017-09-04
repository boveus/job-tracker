class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.average_interest_of_jobs
    joins(:jobs)
    .group(:name)
    .average(:level_of_interest)
  end

  def self.top_three_by_average_interest
    average_interest_hash = average_interest_of_jobs.sort_by {|company, average| average}.reverse.to_h
    average_interest_hash.each do |company, interest|
      average_interest_hash[company] = interest.to_f.round(2)
    end
    average_interest_hash.first(3).to_h
  end
end
