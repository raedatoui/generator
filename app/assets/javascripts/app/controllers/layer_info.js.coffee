class App.LayerInfo extends Exo.Spine.Controller

	className: "layer"

	doActivate: ->
		@onActivated()


	doDeactivate: ->
		@info.deactivate()
		@info.release()
		@onDeactivated()

	prepareWithModel: (item) ->
		@el.empty()
		@item = item
		@render()

	render: =>
		@html @view("layer", @item)
		unless @info
				@info = new App.PropsEditor
				@addChild @info
				@info.appendTo @parent().el
				@info.activate()
		@info.prepareWithModel @item.layer_type()
