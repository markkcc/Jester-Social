class AddAudienceToJests < ActiveRecord::Migration[7.1]
  def change
    add_column :jests, :audience, :string, default: "circus", null: false
    add_index :jests, :audience
  end
end
