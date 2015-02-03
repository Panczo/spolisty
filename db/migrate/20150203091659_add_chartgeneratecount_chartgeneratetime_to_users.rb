class AddChartgeneratecountChartgeneratetimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chartgeneratecount, :integer, default: 0
    add_column :users, :chartgeneratetime, :datetime
  end
end
