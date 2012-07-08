class Job < ActiveRecord::Base
  attr_accessible :name, :location, :description, :user_id
  has_many :comments, :dependent => :delete_all
end
