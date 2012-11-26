class CreateLayerTypes < ActiveRecord::Migration
  def change
    create_table :layer_types do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
