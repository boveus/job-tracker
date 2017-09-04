class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.sort_by_city
    order("city ASC")
  end

  def self.sort_by_interest
    order("level_of_interest DESC")
  end

  def self.count_by_level_of_interest
    group(:level_of_interest)
    .order("count(level_of_interest) DESC")
    .count(:id)
  end

  def self.count_by_city
    group(:city)
    .order("count(city) DESC")
    .count(:id)
  end
end
