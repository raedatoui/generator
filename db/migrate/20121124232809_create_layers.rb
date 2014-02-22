class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
      t.integer :id
      t.integer :layer_type_id
      t.integer :parent_id
      t.string :file

      t.timestamps
    end
  end
end
