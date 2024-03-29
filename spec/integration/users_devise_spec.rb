# encoding: UTF-8
require 'spec_helper'

describe 'an unauthenticated user' do

  let(:user) do
    user = FactoryGirl.create(:homeowner)
    user.confirm!
    user
  end

  def signed_in_user
    click_link('Войти')
    fill_in 'Имя пользователя', :with => user.username
    fill_in 'Пароль', :with => user.password
    click_button 'Войти'
  end

  def signed_up_homeowner
      fill_in 'Имя', :with => 'Ivan'
      fill_in 'Email', :with => 'ivan@pupkin.ru'
      fill_in 'Пароль', :with => 'password'
      fill_in 'Повторите пароль', :with => 'password'
      click_button 'Зарегистрироваться'
      page.should have_content('Вы успешно зарегистрировались. В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашей учётной записи')
      open_email('ivan@pupkin.ru', :with_subject => 'Инструкции по подтверждению учётной записи')
      click_first_link_in_email
      page.should have_content('Ваша учётная запись подтверждена. Теперь вы вошли в систему.')
      page.should have_content('Ivan')
  end

  def signed_up_tradesman
      fill_in 'Имя', :with => 'Ashot'
      fill_in 'Email', :with => 'ashot@bairan.ru'
      fill_in 'Пароль', :with => 'password'
      fill_in 'Повторите пароль', :with => 'password'
      click_button 'Зарегистрироваться'
      page.should have_content('Вы успешно зарегистрировались. В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашей учётной записи')
      open_email('ashot@bairan.ru', :with_subject => 'Инструкции по подтверждению учётной записи')
      click_first_link_in_email
      page.should have_content('Ваша учётная запись подтверждена. Теперь вы вошли в систему.')
      page.should have_content('Ashot')
  end

  before(:each) do
    visit '/'
  end

  context 'homeowner' do
    it 'should be able to sign up' do
      click_link('Зарегистрироваться как заказчик')
      signed_up_homeowner
      User.find_by_username('Ivan').role.should == 'homeowner'
    end
  end

  context 'tradesman' do
    it 'should be able to sign up' do
      click_link('Зарегистрироваться как подрядчик')
      signed_up_tradesman
      User.find_by_email('ashot@bairan.ru').role.should == 'tradesman'
    end
  end

  it 'should be able to sign in' do
    signed_in_user
    page.should have_content(user.username)
  end

  it 'should be able to sign out' do
    signed_in_user
    click_link('Выйти')
    page.should have_content('Выход из системы выполнен')
  end
end
