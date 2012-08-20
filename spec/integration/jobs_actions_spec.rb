# encoding: UTF-8
require 'spec_helper'

describe 'Jobs actions' do

  let(:homeowner) do
    homeowner = FactoryGirl.create(:homeowner)
    homeowner.confirm!
    homeowner
  end

  let(:tradesman) do
    tradesman = FactoryGirl.create(:tradesman, :username => 'Mikhail')
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

  before(:all) do
    @ukladka = FactoryGirl.create(:job, :name => 'Укладка плитки', description: 'Уложить 100 м2 плитки на моей кухне',
                                   location: 'Санкт-Петербург', :user_id => homeowner.id)
    @bid = FactoryGirl.create(:bid, :job_id => @ukladka.id, :user_id => tradesman.id, :accepted => true)
    @pokraska = FactoryGirl.create(:job, :name => 'Покраска пола', 
                                   description: 'Покрасить полы на моей даче', location: 'Нижний Новгород')
    @unrated_job = FactoryGirl.create(:job, :complete => true)
  end

  context 'homeowner' do
    before(:each) do
      signed_in_homeowner
    end

    describe 'Creating jobs' do
      it 'creates new job' do
        visit jobs_path
        click_link 'новая заявка'
        fill_in 'Название', :with => 'Отделка ванной кафелем'
        fill_in 'Описание работ', :with => 'Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалы куплены.'
        fill_in 'Город', :with => 'Санкт-Петербург'
        click_button 'Создать'
        page.should have_content('Отделка ванной кафелем')
        Job.last.user_id.should == homeowner.id
      end
    end

    describe 'Viewing jobs' do

      it 'listing all repair jobs' do
        visit ('/jobs')
        page.should have_content(@ukladka.name)
        page.should have_content(@ukladka.description)
        page.should have_content(@ukladka.location) 
        page.should have_content(@pokraska.name)
        page.should have_content(@pokraska.description)
        page.should have_content(@pokraska.location) 
      end

      it 'displays a single repair job' do
        visit ('/jobs')
        click_link('Покраска пола')
        current_path.should == job_path(@pokraska)
        page.should have_content(@pokraska.name)
        page.should have_content(@pokraska.description)
        page.should have_content(@pokraska.location) 
      end
    end

    describe 'Modifying jobs' do
      it 'should be able to edit own job' do
        visit job_path(@ukladka)
        click_link 'Изменить'
        fill_in 'Описание работ', :with => 'Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалов нет.'
        click_button 'Изменить'
        page.should have_content('Вы успешно изменили свою заявку')
        page.should have_content('Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалов нет.')
      end

      it 'should be able to delete own jobs' do
        visit job_path(@ukladka)
        click_link 'Удалить'
        visit jobs_path
        page.should_not have_content(@ukladka.name)
      end
    end

    it 'can indicate the job is complete' do
      visit job_path(@ukladka)
      click_link 'Работа завершена'
      page.should have_content('Ваша работа завершена. Пожалуйста, оставьте отзыв о работе подрядчика.')
    end

    it 'should be able to rate the job completed' do
      visit job_path(@ukladka)
      click_link "Оставить отзыв для #{tradesman.username}"
      choose 'Понравилось'
      fill_in 'Ваш отзыв', :with => 'Очень хорошая работа.'
      click_on 'Оставить отзыв'
      page.should have_content("Вы оставили отзыв о работнике #{tradesman.username}. Спасибо!")
    end
  end
end
