# encoding: UTF-8
FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "Ivan#{n}" }
    sequence(:email) { |n| "ivan#{n}@email.com" }
    password 'password'
    password_confirmation 'password'
    role 'homeowner'
  end
end
