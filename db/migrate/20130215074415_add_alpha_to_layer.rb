class AddAlphaToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :alpha, :float
  end
end
