class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.date :production_date
      t.integer :turn_number
      t.string :product

      t.timestamps
    end
  end
end
