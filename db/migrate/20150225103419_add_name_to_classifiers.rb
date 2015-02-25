class AddNameToClassifiers < ActiveRecord::Migration
  def change
    add_column :classifiers, :name, :string
  end
end
