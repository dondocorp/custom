class RemoveDayIndexFromProduct < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :day_index, :decimal
  end
end
