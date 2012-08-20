# encoding: UTF-8
class RatingsController < ApplicationController
  before_filter :find_a_job

  def new
    @rating = @job.ratings.build
  end

  def create
    @rating = @job.ratings.build
    @rating.update_attributes(:job_id => @job.id, :homeowner_id => current_user.id, :tradesman_id => params[:tradesman_id])
    if @rating.save
      flash[:notice] = "Вы оставили отзыв о работнике. Спасибо!"
      redirect_to @job
    else
      flash[:alert] = "Что-то пошло не так"
      redirect_to @job
    end
  end

  private

  def find_a_job
    @job = Job.find(params[:job_id])
  end
end
