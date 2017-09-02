class CommentsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.new(comment_params)

    if @comment.save
      flash[:success] = "You created a comment on #{@job.title}"
      redirect_to company_job_path(@job.company, @job)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
