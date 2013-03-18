class App.Tools extends Exo.Spine.Controller

	elements:
		".bar" : "bar"
		".toggle" : "toggleBtn"
		".actions" : "actionsPanel"
		"#add" : "addButton"

	events:
		"click .bar": "togglePanel"
		"click #add" : "showAdd"

	panelClosed = true
	# select, info / props - update, add, delete

	constructor: ->
		super
			initialState: Exo.Node.States.ACTIVATED
		@el.attr "id", "tools"
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
		@addController = new App.AddLayers
		@addController.appendTo @actionsPanel
		@addChild @addController
		@addController.bind "closed", @selectionMade
		@addButton.addClass "selected"

	selectionMade: =>
		@addButton.removeClass "selected"