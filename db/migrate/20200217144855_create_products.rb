class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku
      t.integer :batch_size

      t.timestamps
    end
  end
end
