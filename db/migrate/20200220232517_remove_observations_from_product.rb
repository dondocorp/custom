class RemoveObservationsFromProduct < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :observations, :string
  end
end
