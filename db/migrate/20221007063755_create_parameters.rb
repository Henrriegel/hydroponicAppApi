class CreateParameters < ActiveRecord::Migration[7.0]
  def change
    create_table :parameters do |t|
      t.string :temperature
      t.string :ph
      t.string :conductivity
      t.string :nutrients
      t.string :humidity
      t.references :plant, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
