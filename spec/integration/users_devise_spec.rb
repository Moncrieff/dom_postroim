# encoding: UTF-8
require 'spec_helper'
include Devise::TestHelpers

describe 'an unauthenticated user' do
  before(:each) do
    visit '/'
  end

  it 'should be able to sign up' do
    click_link('Зарегистрироваться')
    fill_in 'Имя', :with => 'Ivan'
    fill_in 'Email', :with => 'ivan@pupkin.ru'
    fill_in 'Пароль', :with => 'password'
    fill_in 'Повторите пароль', :with => 'password'
    click_button 'Зарегистрироваться'
    page.should have_content('Вы успешно зарегистрировались.')
  end
end
