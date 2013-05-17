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
		"click #add" : "showAdd"

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
			@trigger "moved", @el.width() - @bar.width()
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

	showAdd: =>
		console.log @current
		if @current is undefined or @current.constructor.name != "LayerCreator"
			creator = new App.LayerCreator
			creator.bind "closed", @selectionMade
			@activateNext creator
			@addButton.addClass "selected"

	selectionMade: =>
		@addButton.removeClass "selected"

	showNode: (data) =>
		if panelClosed
			@togglePanel()
		$('.button').removeClass
		@infoButton.addClass "selected"
		props = new App.PropsEditor

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

	onControllerDeactivated: (controller) =>
		@removeChild controller
		controller.release()