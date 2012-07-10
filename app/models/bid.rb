class Bid < ActiveRecord::Base
  belongs_to :job
  attr_accessible :comment, :cost, :user_id, :accepted
end
