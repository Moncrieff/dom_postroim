# encoding: UTF-8
class JobsController < ApplicationController

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = "Работа создана."
      redirect_to @job
    else
      flash[:alert] = "Работа не создана."
      render :action => "new"
    end
  end

  def show
    @job = Job.find(params[:id])
  end
end
