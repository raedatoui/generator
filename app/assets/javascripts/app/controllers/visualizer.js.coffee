class App.Visualizer extends Exo.Spine.Controller

	className: 'visualizer'

	CENTER: 450
	HEIGHT: 160
	WIDTH: 160
	PADDING: 10

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

