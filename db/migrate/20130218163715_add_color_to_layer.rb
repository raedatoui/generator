class AddColorToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :color, :string
  end
end
