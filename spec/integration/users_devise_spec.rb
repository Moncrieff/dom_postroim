# encoding: UTF-8
require 'spec_helper'

describe 'an unauthenticated user' do

  let(:user) do
    user = FactoryGirl.create(:user)
    user.confirm!
    user
  end

  def signed_in_user
    click_link('Войти')
    fill_in 'Имя пользователя', :with => user.username
    fill_in 'Пароль', :with => user.password
    click_button 'Войти'
  end

  before(:each) do
    visit '/'
  end

  context 'homeowner' do
    it 'should be able to sign up' do
      click_link('Зарегистрироваться как заказчик')
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
      User.find_by_username('Ivan').role.should == 'homeowner'
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
