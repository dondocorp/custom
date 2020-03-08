class CreateBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :batches do |t|
      t.string :input
      t.string :product
      t.date :cook_date

      t.timestamps
    end
  end
end
