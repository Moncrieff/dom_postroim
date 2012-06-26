# encoding: UTF-8
require "spec_helper"
require "capybara/rspec"
describe "Viewing jobs" do
  before(:all) do
  # Background: 
  # => Given there are jobs called "Укладка плитки" and "Покраска пола"
  ukladka = FactoryGirl.create(:job, :name => "Укладка плитки")
  pokraska = FactoryGirl.create(:job, :name => "Покраска пола")
  # => And I am on the jobs index page
  visit ("/jobs")
  end

  it "listing all repair jobs" do
    page.should have_content("Укладка плитки") 
    page.should have_content("Покраска пола")
  end
end

  #scenario "listing all repair jobs" do
  #end
