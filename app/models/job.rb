class Job < ActiveRecord::Base
  attr_accessible :name, :location, :description
  has_many :comments, :dependent => :delete_all
end
