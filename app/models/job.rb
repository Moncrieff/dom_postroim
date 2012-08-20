class Job < ActiveRecord::Base
  attr_accessible :name, :location, :description, :user_id, :accepted, :complete
  has_many :comments, :dependent => :delete_all
  has_many :bids, :dependent => :delete_all
  has_many :ratings
end
