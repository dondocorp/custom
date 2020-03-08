class ChangeDayIndexToBeFloatInProduct < ActiveRecord::Migration[6.0]
  def change
  	change_column :products, :day_index, :float
  end
end
