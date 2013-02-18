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
		@currentEditorData = item
		@activateNext new App.PropsEditor


	activateNext: (next) ->
		unless @next
			@next = next
			@addChild @next											# Add the section to the controller hierarchy
			@next.bind "onDeactivated", @onControllerDeactivated	# Get notified when the controller is deactivated
			@next.bind "onActivated", @onControllerActivated		# and activated.
			@next.appendTo @parent().el										# Also append it's @el to the DOM.
			@next.activate()										# Attempt to activate the section.

	onControllerActivated: (controller) =>
		@current = controller
		@current.prepareWithModel @currentEditorData
		@next = null

	onControllerDeactivated: (controller) =>
		@removeChild controller
		controller.release()
		#talk to the button controller OR use jquery
		$('.layer-type .button').removeClass "selected"