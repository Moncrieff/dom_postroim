#encoding: UTF-8
require 'spec_helper'
include Devise::TestHelpers

describe BidsController do
  let(:homeowner) do
    homeowner = FactoryGirl.create(:homeowner)
    homeowner.confirm!
    homeowner
  end

  let(:tradesman) do
    tradesman = FactoryGirl.create(:tradesman)
    tradesman.confirm!
    tradesman
  end

  let (:job) do
    job = FactoryGirl.create(:job, :user_id => 100500)
  end

  let (:bid) do
    bid = FactoryGirl.create(:bid, :job_id => job.id)
  end

  def cannot_act_on_bids!
    response.should redirect_to(job)
    flash[:alert].should == 'Вы не можете этого сделать.'
  end

  context 'homeowner' do
    before(:each) do
      sign_in(:user, homeowner)
    end

    it 'cannot create bids' do
      get :new, { :job_id => job.id, :id => bid.id }
      cannot_act_on_bids!
    end

    it 'cannot accept bids for other homeowners jobs' do
      put :accept, { :job_id => job.id, :id => bid.id }
      cannot_act_on_bids!
    end
  end

  context 'tradesman' do
    it 'cannot accept bids' do
      sign_in(:user, tradesman)
      put :accept, { :job_id => job.id, :id => bid.id }
      cannot_act_on_bids!
    end
  end
end
