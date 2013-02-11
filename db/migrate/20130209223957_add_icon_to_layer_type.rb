class AddIconToLayerType < ActiveRecord::Migration
  def change
    add_column :layer_types, :icon, :string
  end
end
