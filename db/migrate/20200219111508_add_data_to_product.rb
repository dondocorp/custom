class AddDataToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :unit_type, :string
    add_column :products, :observations, :string
    add_column :products, :day_index, :decimal, precision: 3, scale: 3
  end
end
