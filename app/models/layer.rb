class Layer < ActiveRecord::Base
  attr_accessible :file, :id, :layer_type, :parent_id
end
