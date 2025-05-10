class AddUniqueConstraintToSessions < ActiveRecord::Migration[7.1]
  def up
    # Remove duplicate sessions first
    execute <<-SQL
      DELETE FROM sessions 
      WHERE id NOT IN (
        SELECT MIN(id)
        FROM sessions
        GROUP BY user_id
      );
    SQL

    # Only add the index if it doesn't exist
    unless index_exists?(:sessions, :user_id)
      add_index :sessions, :user_id, unique: true
    end
  end

  def down
    remove_index :sessions, :user_id if index_exists?(:sessions, :user_id)
  end
end
