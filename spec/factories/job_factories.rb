# encoding: UTF-8
FactoryGirl.define do
  factory :job do
    name 'Замена окон'
  end

  factory :bid do
    cost '2,000'
    comment 'Торгуемо'
    user_id '1'
    job_id '1'
  end
end
