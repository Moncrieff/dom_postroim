# encoding: UTF-8
require 'spec_helper'

describe 'As a user I should be able' do
  before(:all) do
    @repair = FactoryGirl.create(:job)
    @comment = FactoryGirl.create(:comment, :job_id => @repair.id, :text => 'У меня вопрос')
  end

  before(:each) do
    visit job_path(@repair)
  end

  describe 'to create comments' do
    it 'should allow to create comment' do
      click_link('Задать вопрос')
      fill_in 'Вопрос', :with => 'Насколько срочно вам надо сделать?'
      click_button 'Создать'
      page.should have_content('Вы задали вопрос')
    end
  end

  describe 'to read comments' do
    it 'should allow to read comments' do
      page.should have_content(@comment.text)
    end
  end

  describe 'to reply to comments' do
    pending
  end
end
