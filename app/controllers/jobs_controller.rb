class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def all_jobs
    if params[:location]
      @jobs = Job.filter_by_city(params[:location])
    elsif params[:sort] == 'location'
      @jobs = Job.sort_by_city
    elsif params[:sort] == 'interest'
      @jobs = Job.sort_by_interest
    else
      @jobs = Job.all
    end
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
  end

  def create
    @company = Company.find(params[:company_id])
    @category = Category.find_or_create_by(title: params[:job][:category])
    @job = @company.jobs.new(job_params)
    @job.category = @category

    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @company = @job.company
    @comment = Comment.new
  end

  def edit
    @company = Company.find(params[:company_id])
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    @category = Category.find_or_create_by(title: params[:job][:category])
    @job.update(job_params)
    @job.category = @category
    if @job.save
      flash[:success] = "#{@job.title} updated!"

      redirect_to company_job_path(@job.company.id, @job.id)
    else
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy

    flash[:success] = "#{job.title} was successfully deleted!"
    redirect_to company_jobs_path(params[:company_id])
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city)
  end
end
