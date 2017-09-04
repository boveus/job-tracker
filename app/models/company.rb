class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :jobs, dependent: :destroy
  has_many :contacts, dependent: :destroy

  def self.average_interest_of_jobs
    joins(:jobs)
    .group(:name)
    .average(:level_of_interest)
  end
end
