class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :currentState
      t.string :string

      t.timestamps
    end
  end
end
