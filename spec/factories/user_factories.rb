# encoding: UTF-8
FactoryGirl.define do
  sequence(:email) { |n| "email_#{n}@mail.ru" }
  sequence(:username) { |n| "Ivan#{n}" }

  factory :user do
    username
    email
    password 'password'
    password_confirmation 'password'

    factory :tradesman do
      role 'tradesman'
    end

    factory :homeowner do
      role 'homeowner'
    end
  end
end
