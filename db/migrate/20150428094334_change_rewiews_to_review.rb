class ChangeRewiewsToReview < ActiveRecord::Migration
  def change
    rename_table :rewiews, :reviews
  end
end
