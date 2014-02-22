class AddBlendToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :blend, :string
  end
end
