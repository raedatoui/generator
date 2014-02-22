class AddFieldsToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :width, :integer
    add_column :layers, :height, :integer
    add_column :layers, :layer_width, :integer
    add_column :layers, :layer_height, :integer
  end
end
