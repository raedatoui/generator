class App.Visualizer extends Exo.Spine.Controller

	className: 'visualizer'

	CENTER: 450
	HEIGHT: 160
	WIDTH: 160
	PADDING: 10

	constructor: ->
		super
		@el.attr "id", "mCanvas"
		@render()

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

	render: =>
		setTimeout =>
			@keep_rendering()
		, 250

	keep_rendering: =>

		# paper.setup(@el[0])
		# for i of App.Layer.all()
		# 	rect = new paper.Rectangle(200*i, 100*i, 200, 100)
		# 	path = new paper.Path.Rectangle(rect)
		# 	path.fillColor = '#e9e9ff'

		# 	# Draw the view now:
		# paper.view.draw()


