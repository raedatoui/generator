class AddAncestryToLayers < ActiveRecord::Migration
  def up
    add_column :layers, :ancestry, :string
    add_index :layers, :ancestry
  end
end
