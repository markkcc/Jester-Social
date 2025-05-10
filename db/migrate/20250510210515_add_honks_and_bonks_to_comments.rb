class AddHonksAndBonksToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :honks_count, :integer, default: 0, null: false
    add_column :comments, :bonks_count, :integer, default: 0, null: false
  end
end
