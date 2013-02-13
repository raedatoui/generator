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
			btn.bind "selected", @handleSelection
		TweenLite.to @el, 0.75,
			height: 250

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		TweenLite.to @el, 0.75,
			height: 0
			onComplete: =>
				@trigger "closed"
				@el.remove()
				@onDeactivated()

	handleSelection: (item) =>
		console.log @parent().el
		@editor = new App.PropsEditor
		@editor.appendTo @parent().el
		@editor.prepareWithModel item