class Layer < ActiveRecord::Base
	has_ancestry
	attr_accessible :file, :id, :layer_type, :parent_id
end
