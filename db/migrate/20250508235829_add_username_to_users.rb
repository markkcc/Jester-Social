class AddUsernameToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :username, :string
    # Copy email_address to username for existing users
    execute <<-SQL
      UPDATE users SET username = email_address WHERE username IS NULL;
    SQL
    # Make username non-nullable
    change_column_null :users, :username, false
    # Add unique index
    add_index :users, :username, unique: true
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end
