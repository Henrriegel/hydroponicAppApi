class CreateLectures < ActiveRecord::Migration[7.0]
  def change
    create_table :lectures do |t|
      t.string :roomTemperature
      t.string :temperature1
      t.string :temperature2
      t.string :ph
      t.string :roomHumidity
      t.references :sensor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
