class App.LayerTypeSelector extends Spine.Controller

	className: "layer-type"

	events:
		"click" : "handleClick"
		"mouseover"	: "handleMouseOver"
		"mouseout"	: "handleMouseOut"

	elements:
		".button" : "button"

	constructor: ->
		super
		throw '@item required' unless @item
		@render()

	render: =>
		@html @view("add_layer_type",@item)
		# TweenLite.to @el, 1,
		# 	css:
		# 		autoAlpha: 1
		# 	delay: 0.1*@item.id
		#@el.attr "style", "background-image:url("+ @item.icon.url + ")"

	handleClick: =>
		$(".layer-type .button").removeClass "selected"
		@button.addClass "selected"
		@trigger "selected", @item

	handleMouseOver: =>
		@trigger "mouseover", @item

	handleMouseOut: =>
		@trigger "mouseout", @item
