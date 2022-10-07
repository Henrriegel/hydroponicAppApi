class CreateLectures < ActiveRecord::Migration[7.0]
  def change
    create_table :lectures do |t|
      t.string :temperature
      t.string :ph
      t.string :conductivity
      t.string :nutrients
      t.string :humidity
      t.references :sensor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
