class App.PropsEditor extends Exo.Spine.Controller

	className: "props"

	constructor: ->
		super
			initialState: Exo.Node.States.ACTIVATED

	prepareWithModel: (item) =>
		@item = item
		@render()

	render: =>
		@html @view(@item.slug+"_editor",@item)

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()