# encoding: UTF-8
require "spec_helper"
describe "Viewing jobs" do
  before(:each) do
  # Background: 
  # => Given there are jobs called "Укладка плитки" and "Покраска пола"
  @ukladka = FactoryGirl.create(:job, :name => "Укладка плитки", 
                                description: "Уложить 100 м2 плитки на моей кухне", location: "Санкт-Петербург")
  @pokraska = FactoryGirl.create(:job, :name => "Покраска пола", 
                                 description: "Покрасить полы на моей даче", location: "Нижний Новгород")
  # => And I am on the jobs index page
  visit ("/jobs")
  end

  it "listing all repair jobs" do
    page.should have_content(@ukladka.name)
    page.should have_content(@ukladka.description)
    page.should have_content(@ukladka.location) 
    page.should have_content(@pokraska.name)
    page.should have_content(@pokraska.description)
    page.should have_content(@pokraska.location) 
  end

  it "displays a single repair job" do
    click_link("Покраска пола")
    current_path.should == job_path(@pokraska.id)
    page.should have_content(@pokraska.name)
    page.should have_content(@pokraska.description)
    page.should have_content(@pokraska.location) 
  end
end

  #scenario "listing all repair jobs" do
  #end
