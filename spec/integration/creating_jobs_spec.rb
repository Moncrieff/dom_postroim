# encoding: UTF-8
require "spec_helper"

describe "Creating jobs" do
  it "creates new job" do
    visit jobs_path
    click_link "новая заявка"
    fill_in "Название", :with => "Отделка ванной кафелем"
    fill_in "Описание работ", :with => "Обложить ванну размером 4 на 5 метров кафельной плиткой. Материалы куплены."
    fill_in "Город", :with => "Санкт-Петербург"
    click_button "Создать"
    page.should have_content("Отделка ванной кафелем")
  end
end
