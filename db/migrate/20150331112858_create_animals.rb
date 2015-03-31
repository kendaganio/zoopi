class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.references :zoo

      t.timestamps null: false
    end
  end
end
