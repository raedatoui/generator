class RemoveParentIdFromLayer < ActiveRecord::Migration
  def up
    remove_column :layers, :parent_id
  end

  def down
    add_column :layers, :parent_id, :integer
  end
end
