class AddUniqueIndexToSessions < ActiveRecord::Migration[8.0]
  def change
    add_index :sessions, [:user_id, :created_at], unique: true
  end
end
