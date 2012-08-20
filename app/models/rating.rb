class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  attr_accessible :comment, :evaluation, :job_id, :homeowner_id, :tradesman_id
  #validates :evaluation, :inclusion => EVALUATION, :message => "%{value} is not valid"

  EVALUATION = %w[like didnt_like]
end
