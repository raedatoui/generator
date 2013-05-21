class App.Tools extends Exo.Spine.Controller

	className: "tools"

	elements:
		".bar" : "bar"
		".toggle" : "toggleBtn"
		".actions" : "actionsPanel"
		"#add" : "addButton"
		"#info" : "infoButton"

	events:
		"click .bar": "togglePanel"
		"click #add" : "showCreator"

	panelClosed = true
	# select, info / props - update, add, delete

	constructor: ->
		super
			initialState: Exo.Node.States.ACTIVATED

		panelClosed = true
		@render()

	render: =>
		@html @view("tools")

	togglePanel: =>
		if panelClosed
			@trigger "moved", 342
			TweenLite.to @el, .5,
				css:
					left: 0
				onComplete: =>
					panelClosed = false
					@toggleBtn.removeClass("ui-bar-open").addClass("ui-bar-close")
		else
			@trigger "moved", @bar.width()
			TweenLite.to @el, .5,
				css:
					left: -@el.width() + @bar.width()
				onComplete: =>
					panelClosed = true
					@toggleBtn.removeClass("ui-bar-closed").addClass("ui-bar-open")

	showCreator: =>
		$('.button').removeClass "selected"
		if @current is undefined or @current.constructor.name != "LayerCreator"
			creator = new App.LayerCreator
			creator.bind "closed", @selectionMade
			@activateNext creator
			@addButton.addClass "selected"

	showInfo: (data) =>
		console.log data
		if panelClosed
			@togglePanel()
		$('.button').removeClass "selected"
		@infoButton.addClass "selected"

		App.Layer.currentLayer = App.Layer.find(data.id)
		if @current && @current.constructor.name  is "LayerInfo"
			@current.prepareWithModel App.Layer.currentLayer
		else
			props = new App.LayerInfo
			@activateNext props

	selectionMade: =>
		@addButton.removeClass "selected"

	activateNext: (next) ->
		unless @next
			@next = next
			@addChild @next											# Add the section to the controller hierarchy
			@next.bind "onDeactivated", @onControllerDeactivated	# Get notified when the controller is deactivated
			@next.bind "onActivated", @onControllerActivated		# and activated.
			@next.appendTo @actionsPanel										# Also append it's @el to the DOM.
			@next.activate()										# Attempt to activate the section.

	onControllerActivated: (controller) =>
		@current = controller
		@next = null
		if @current.constructor.name is "LayerInfo"
			@current.prepareWithModel App.Layer.currentLayer

	onControllerDeactivated: (controller) =>
		@removeChild controller
		controller.release()
