# encoding: UTF-8
class BidsController < ApplicationController
  before_filter :find_job
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to @job, :alert => 'Вы не можете этого сделать.'
  end

  def new
    authorize! :create_bid_for_job, @job
    @bid = @job.bids.build
  end

  def create
    authorize! :create_bid_for_job, @job
    @bid = @job.bids.build(params[:bid].try(:merge!, :user_id => current_user.id))
    if @bid.save
      flash[:notice] = 'Вы успешно откликнулись на заявку'
      redirect_to @job
    else
      flash[:alert] = 'Что-то пошло не так. Вы не откликнулись на заявку'
      redirect_to @job
    end
  end

  def accept
    authorize! :accept_bids, @job, :message => 'Вы не можете этого сделать.'
    @bid = @job.bids.find(params[:id])
    @bid.update_attributes(:accepted => true)
    @job.update_attributes(:accepted => true)
    flash[:notice] = 'Вы приняли предложение от подрядчика'
    redirect_to @job
  end


  private

  def find_job
    @job = Job.find(params[:job_id])
  end
end
