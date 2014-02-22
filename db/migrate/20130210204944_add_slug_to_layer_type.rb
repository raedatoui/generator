class AddSlugToLayerType < ActiveRecord::Migration
  def change
    add_column :layer_types, :slug, :string
  end
end
