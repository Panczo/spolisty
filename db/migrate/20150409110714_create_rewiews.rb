class CreateRewiews < ActiveRecord::Migration
  def change
    create_table :rewiews do |t|
      t.integer :rating
      t.text :comment
      t.integer :user_id
      t.integer :playlist_id

      t.timestamps null: false
    end
    add_index :rewiews, :user_id
    add_index :rewiews, :playlist_id
  end
end
