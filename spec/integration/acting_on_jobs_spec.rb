# encoding: UTF-8
require 'spec_helper'

describe 'Jobs actions' do

  let(:homeowner) do
    homeowner = FactoryGirl.create(:homeowner)
    homeowner.confirm!
    homeowner
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
  @pokraska = FactoryGirl.create(:job, :name => 'Покраска пола', 
                                 description: 'Покрасить полы на моей даче', location: 'Нижний Новгород')
  end

  context 'signed in homeowner' do
    before(:all) do
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
        signed_in_homeowner
        visit job_path(@ukladka)
        click_link 'Изменить'
        fill_in 'Описание работ', :with => 'Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалов нет.'
        click_button 'Изменить'
        page.should have_content('Вы успешно изменили свою заявку')
        page.should have_content('Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалов нет.')
      end

      it 'should be able to delete own jobs' do
        signed_in_homeowner
        visit job_path(@ukladka)
        click_link 'Удалить'
        visit jobs_path
        page.should_not have_content(@ukladka.name)
      end
    end
  end
end
