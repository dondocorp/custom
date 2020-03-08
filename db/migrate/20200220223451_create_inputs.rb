class CreateInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :inputs do |t|
      t.string :product
      t.integer :quantity
      t.date :delivery_date

      t.timestamps
    end
  end
end
