class App.PropsEditor extends Exo.Spine.Controller

	className: "props"

	constructor: ->
		super
			initialState: Exo.Node.States.ACTIVATED

	prepareWithModel: (item) =>
		@item = item
		@render()
		$("form input").live "change", ->
			$(this).parents("form:first").submit()


	render: =>
		@html @view(@item.slug+"_editor",@item)

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()