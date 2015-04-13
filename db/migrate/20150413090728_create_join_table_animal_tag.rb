class CreateJoinTableAnimalTag < ActiveRecord::Migration
  def change
    create_join_table :animals, :tags, column_options: {null: true} do |t|
      # t.index [:animal_id, :tag_id]
      # t.index [:tag_id, :animal_id]
    end
  end
end
