class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :cost
      t.string :comment

      t.timestamps
    end
  end
end
