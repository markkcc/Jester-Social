class AddUserToJests < ActiveRecord::Migration[8.0]
  def change
    add_reference :jests, :user, null: true, foreign_key: true
  end
end
