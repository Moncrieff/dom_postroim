# encoding: UTF-8
class CommentsController < ApplicationController
  before_filter :find_a_job


  def new
    @comment = @job.comments.build
  end

  def create
    @comment = @job.comments.build(params[:comment].try(:merge!, :user => current_user))
    if @comment.save
      flash[:notice] = 'Вы задали вопрос.'
      redirect_to @job
    else
      flash[:alert] = 'Что-то пошло не так. Вопрос не был задан.'
      render 'new'
    end
  end

  private
  def find_a_job
    @job = Job.find(params[:job_id])
  end
end
