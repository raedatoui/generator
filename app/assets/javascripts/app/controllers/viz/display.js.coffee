class App.Display extends Exo.Spine.Controller

	constructor: ->
		super
		@render()

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

	render: =>
		@html @view("visualizer")
