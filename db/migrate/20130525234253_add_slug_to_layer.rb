class AddSlugToLayer < ActiveRecord::Migration
  def change
    add_column :layers, :slug, :string
  end
end
