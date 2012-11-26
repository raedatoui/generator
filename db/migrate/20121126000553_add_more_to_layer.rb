class AddMoreToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :scale, :float
    add_column :layers, :name, :string
  end
end
