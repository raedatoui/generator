class LayerType < ActiveRecord::Base

  attr_accessible :id, :name, :icon, :slug
  validate :name, uniqueness: true
  has_many :layers
  mount_uploader :icon, IconUploader

end
