# encoding: UTF-8
FactoryGirl.define do
  factory :comment do
    text 'Хотел бы задать один вопрос'
    job_id '1'
    user_id '1'
  end
end
