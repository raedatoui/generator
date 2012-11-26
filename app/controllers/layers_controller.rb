class LayersController < ApplicationController

	respond_to :html, :json

	def index
		@layers = Layer.all
		respond_with @layers

	end

	def types
		@types = LayerType.all
		respond_with @types
	end
end