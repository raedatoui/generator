class App.Layers extends Spine.Controller

	classname: "layer"

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

	prepareWithModel: (item) ->
		@item = item
		@render()

	render: =>
		@html @view("layer", @item)