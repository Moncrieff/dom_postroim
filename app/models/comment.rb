class Comment < ActiveRecord::Base
  attr_accessible :text, :user
  belongs_to :job
  belongs_to :user
  validates_presence_of :text
end
