class DashboardController < ApplicationController
  def dashboard
    @count_by_level_of_interest = Job.count_by_level_of_interest
    @count_by_city = Job.count_by_city
    @top_three_companies_by_interest = Company.top_three_by_average_imterest
  end
end
