class CreateJests < ActiveRecord::Migration[8.0]
  def change
    create_table :jests do |t|
      t.text :content

      t.timestamps
    end
  end
end
