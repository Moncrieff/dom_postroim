# encoding: UTF-8
require 'spec_helper'

describe 'bids actions' do
  before(:all) do
    @job = FactoryGirl.create(:job, :user_id => homeowner.id)
    @bid = FactoryGirl.create(:bid, :job_id => @job.id, :user_id => tradesman.id)
  end

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

  def signed_in_homeowner
    visit jobs_path
    click_link('Войти')
    fill_in 'Имя пользователя', :with => homeowner.username
    fill_in 'Пароль', :with => homeowner.password
    click_button 'Войти'
  end

  def signed_in_tradesman
    visit jobs_path
    click_link('Войти')
    fill_in 'Имя пользователя', :with => tradesman.username
    fill_in 'Пароль', :with => tradesman.password
    click_button 'Войти'
  end

  context 'tradesman' do
    it 'should be able to bid on a job' do
      signed_in_tradesman
      visit job_path(@job)
      click_link 'Откликнуться'
      fill_in 'Стоимость', :with => '3,000 - 5,000 руб.'
      fill_in 'Комментарий', :with => 'Стоимость сильно зависит от того, какие материалы у вас есть.'
      click_button 'Откликнуться'
      page.should have_content('Вы успешно откликнулись на заявку')
      page.should have_content('3,000 - 5,000 руб.')
      page.should have_content('Стоимость сильно зависит от того, какие материалы у вас есть.')
      page.should have_link(tradesman.username)
    end

    it 'should be able to delete own bid'
  end

  context 'homeowner' do
    it 'should be able to accept bids for own jobs' do
      signed_in_homeowner
      visit job_path(@job)
      click_link 'Принять'
      page.should have_content('Вы приняли предложение от подрядчика')
    end
  end
end
