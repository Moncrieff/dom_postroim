# encoding: UTF-8
class JobsController < ApplicationController
  load_and_authorize_resource :only => [:new, :create, :edit, :destroy]
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to jobs_path, :alert => 'Вы не можете этого сделать.'
  end

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job].merge!(:user_id => current_user.id))
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

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:notice] = 'Вы успешно изменили свою заявку'
      redirect_to @job
    else
      flash[:alert] = 'Вы не изменили заявку'
      redirect_to @job
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = 'Вы удалили свою заявку'
    redirect_to jobs_path
  end
end
