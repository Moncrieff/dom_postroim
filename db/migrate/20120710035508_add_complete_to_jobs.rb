class AddCompleteToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :complete, :boolean
  end
end
