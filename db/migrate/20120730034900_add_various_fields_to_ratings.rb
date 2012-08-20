class AddVariousFieldsToRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :user
    remove_column :ratings, :job
    add_column :ratings, :job_id, :integer
    add_column :ratings, :homeowner_id, :integer
    add_column :ratings, :tradesman_id, :integer
  end
end
