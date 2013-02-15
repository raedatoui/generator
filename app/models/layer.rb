class Layer < ActiveRecord::Base
	# attr_accessible :file, :id, :layer_type_id, :width, :height, :x, :y, :scale, :clones, :position, :name, :layer_width, :layer_height, :parent, :layer_type

	belongs_to :layer_type

	has_ancestry

	mount_uploader :file, GraphicUploader

	attr_protected
end
