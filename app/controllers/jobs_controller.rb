class JobsController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def all_jobs
    if params[:sort] == 'location'
      @jobs = Job.sort_by_city
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
#
# The user can create a new Category by filling out a form. Each Category has a title (e.g. “Web Development”, “Education”, “Finance”).
# When the user successfully creates a Category they are shown a page with the Category title.
# When the user tries to create a Category that already exists, they are brought back to the page with the form to create a Category.
# The user can view a list of all Categories on a single page, and each Category can be deleted from that page. There is also a link to “Edit” each Category, which takes the user to a form where they can update the Category.
# When the user creates a new Job, they are required to select its Category from a drop down menu of existing categories. They also see a link to create a new Category.
# When the user visits a page for a specific Category, they see a list of Jobs in that Category
