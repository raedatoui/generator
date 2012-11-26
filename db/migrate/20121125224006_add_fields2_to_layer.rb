class AddFields2ToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :clones, :integer
    add_column :layers, :x, :integer
    add_column :layers, :y, :integer
    add_column :layers, :position, :string
  end
end
