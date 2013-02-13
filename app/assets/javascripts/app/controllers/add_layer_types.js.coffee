class App.AddLayerTypes extends Spine.Controller

	className: "layer-type"

	constructor: ->
		super
		throw '@item required' unless @item
		@render()

	render: =>
		@html @view("add_layer_type",@item)
		#@el.attr "style", "background-image:url("+ @item.icon.url + ")"


