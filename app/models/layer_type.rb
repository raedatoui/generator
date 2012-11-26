class LayerType < ActiveRecord::Base
  attr_accessible :id, :name
  has_many :layers
end
