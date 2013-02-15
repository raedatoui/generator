class LayersController < InheritedResources::Base

	respond_to :html, :json


	def types
		@types = LayerType.all
		respond_with @types
	end
end