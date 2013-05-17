class Layer < ActiveRecord::Base

  attr_accessible :file, :id, :layer_type_id, :width, :height, :x, :y, :scale, :clones, :position, :name, :layer_width, :layer_height, :parent, :layer_type

  belongs_to :layer_type

  has_ancestry

  mount_uploader :file, GraphicUploader

  def self.json_tree nodes
    nodes.map do |node, sub_nodes|
      {:name => node.name, :id => node.id, :children => json_tree(sub_nodes).compact}
    end
  end

  def to_node
    result = {}
    self.attributes.each do |attr|
      result[attr[0]] = attr[1]
    end
    result["children"] = self.children.map { |c| c.to_node }
    result
  end


end
