class App.AddLayers extends Exo.Spine.Controller

	className: "add-layers"

	constructor: ->
		super
			initialState: Exo.Node.States.ACTIVATED
		panelClosed = true
		@render()

	render: =>
		for type in App.LayerType.all()
			btn = new App.AddLayerTypes(item:type)
			@append btn
		TweenLite.to @el, 1,
			height: 200

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

