class AddIdentityToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :identity, :string, null: false, default: 'jester'
  end
end
