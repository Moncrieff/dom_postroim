class AddDescriptionAndLocationToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :description, :string
    add_column :jobs, :location, :string
  end
end
