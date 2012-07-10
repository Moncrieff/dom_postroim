class AddAcceptedToBids < ActiveRecord::Migration
  def change
    add_column :bids, :accepted, :boolean
  end
end
