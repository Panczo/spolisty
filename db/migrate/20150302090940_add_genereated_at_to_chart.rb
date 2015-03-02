class AddGenereatedAtToChart < ActiveRecord::Migration
  def change
    add_column :charts, :generated_at, :datetime
  end
end
