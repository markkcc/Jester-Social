class AddHonksAndBonksToJests < ActiveRecord::Migration[7.1]
  def change
    add_column :jests, :honks_count, :integer, default: 0, null: false
    add_column :jests, :bonks_count, :integer, default: 0, null: false
  end
end
