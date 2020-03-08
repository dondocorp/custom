class AddObservationsToInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :inputs, :observations, :text
  end
end
