class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :value
    end
  end
end
