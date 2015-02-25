class CreateClassifiers < ActiveRecord::Migration
  def change
    create_table :classifiers do |t|
      t.text :music_classifier

      t.timestamps null: false
    end
  end
end
