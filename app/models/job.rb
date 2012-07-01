class Job < ActiveRecord::Base
  attr_accessible :name, :location, :description
end
