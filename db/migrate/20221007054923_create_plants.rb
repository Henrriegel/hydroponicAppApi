class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name

      t.timestamps
    end
    add_index :plants, :name, unique: true
  end
end
