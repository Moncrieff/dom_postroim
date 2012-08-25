# encoding: UTF-8
require 'spec_helper'
include Devise::TestHelpers

describe JobsController do
  let(:homeowner) do
    homeowner = FactoryGirl.create(:homeowner)
    homeowner.confirm!
    homeowner
  end

  let(:another_homeowner) do
    another_homeowner = FactoryGirl.create(:homeowner)
    another_homeowner.confirm!
    another_homeowner
  end

  let(:tradesman) do
    tradesman = FactoryGirl.create(:tradesman)
    tradesman.confirm!
    tradesman
  end

  let (:job) do
    job = FactoryGirl.create(:job)
  end

  let(:another_job) do
    another_job = FactoryGirl.create(:job, :user_id => another_homeowner.id)
  end

  def cannot_act_on_jobs!
    response.should redirect_to(jobs_path)
    flash[:alert].should == 'Вы не можете этого сделать.'
  end

  context 'tradesman' do
    before(:each) do
      sign_in(:user, tradesman)
    end

    it 'cannot begin to create a job' do
      get :new, :job_id => job.id
      cannot_act_on_jobs!
    end

    it 'cannot create new job' do
      post :create, :job_id => job.id
      cannot_act_on_jobs!
    end

    it 'cannot edit the job' do
      get :edit, :id => job.id
      cannot_act_on_jobs!
    end

    it 'cannot delete jobs' do
      delete :destroy, :id => job.id
      cannot_act_on_jobs!
    end

    it 'cannot complete the job' do
      put :complete, :job_id => job.id
      cannot_act_on_jobs!
    end
  end

  context 'homeowner' do
    before(:each) do
      sign_in(:user, homeowner)
    end

    it 'cannot edit other homeowners jobs' do
      get :edit, :id => another_job.id
      cannot_act_on_jobs!
    end

    it 'cannot delete other homeowners jobs' do
      delete :destroy, :id => another_job.id
      cannot_act_on_jobs!
    end

    it 'cannot complete other homeowners jobs' do
      put :complete, :job_id => another_job.id
      response.should redirect_to(another_job)
    end
  end
end
