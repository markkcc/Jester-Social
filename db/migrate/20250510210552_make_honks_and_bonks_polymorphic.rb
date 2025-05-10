class MakeHonksAndBonksPolymorphic < ActiveRecord::Migration[7.1]
  def change
    # Honks
    remove_index :honks, :jest_id if index_exists?(:honks, :jest_id)
    remove_column :honks, :jest_id, :integer
    add_column :honks, :honkable_type, :string
    add_column :honks, :honkable_id, :integer
    add_index :honks, [:honkable_type, :honkable_id]

    # Bonks
    remove_index :bonks, :jest_id if index_exists?(:bonks, :jest_id)
    remove_column :bonks, :jest_id, :integer
    add_column :bonks, :bonkable_type, :string
    add_column :bonks, :bonkable_id, :integer
    add_index :bonks, [:bonkable_type, :bonkable_id]
  end
end
