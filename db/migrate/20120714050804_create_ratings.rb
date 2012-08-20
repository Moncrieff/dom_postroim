class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :user
      t.string :job
      t.text :comment
      t.string :evaluation

      t.timestamps
    end
    add_index :ratings, :user
    add_index :ratings, :job
  end
end
