class ChangeDayIndexToBeIntegerInProduct < ActiveRecord::Migration[6.0]
  def change
  	change_column :products, :day_index, :integer
  end
end
