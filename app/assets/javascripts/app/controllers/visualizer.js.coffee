class App.Visualizer extends Exo.Spine.Controller

	className: 'visualizer'

	events:
		"click #rotate" : "toggleLayout"
	constructor: ->
		super
		@el.attr "id", "mCanvas"
		@rootNode = undefined
		@render()

	doActivate: ->
		@onActivated()

	doDeactivate: ->
		@onDeactivated()

	render: =>
		@html @view("visualizer")
		setTimeout =>
			@keep_rendering()
		, 250

	keep_rendering: =>
		w = @el.width()
		h = @el.height()
		@i = 0
		@duration = 500
		@vis = d3.select("#mCanvas").append("svg:svg").attr("width", w).attr("height", h).append("svg:g").attr("transform", "translate(40,40)")
		d3.json "flare.json", (json) =>
			console.log json
			json.x0 = 800
			json.y0 = 0
			@rootNode = json
			@setLayoutMode "h"

		$(window).resize @debounce


	debounce: =>
		timeoutID = -1
		clearTimeout timeoutID  if timeoutID > -1
		timeoutID = setTimeout =>
			@setLayoutMode @layoutMode
		, 125
		console.log

	toggleLayout: =>
		if @layoutMode is "h"
			@setLayoutMode "v"
		else
			@setLayoutMode "h"

	setLayoutMode: (mode) =>
		@layoutMode = mode
		w = @el.width()
		h = @el.height()
		@vis.attr("width", w).attr("height", h)
		console.log @vis
		if mode is "h"
			@updateFunc = @updateH
			@tree = d3.layout.tree().size([w-160, h-160])
			@diagonal = d3.svg.diagonal().projection((d) ->
				[d.x, d.y]
			)
		else
			console.log mode
			@updateFunc = @updateV
			@tree = d3.layout.tree().size([h-160, w - 160])
			@diagonal = d3.svg.diagonal().projection((d) ->
				[d.y, d.x]
			)

		@updateFunc?(@rootNode)

	slide: (w) =>
		TweenLite.to @el, .5,
			css:
				left: w

	updateH: (source) =>
		# Compute the new tree layout.
		nodes = @tree.nodes(@rootNode).reverse()

		# Update the nodes…
		node = @vis.selectAll("g.node").data(nodes, (d) =>
			d.id or (d.id = ++@i)
		)
		nodeEnter = node.enter().append("svg:g").attr("class", "node").attr("transform", (d) ->
			"translate(" + source.x0 + "," + source.y0 + ")"
		).on("mouseover", (d) =>
			d3.select("text").remove()
			@vis.append("text").text(d.name).attr("x", d.x+16).attr("y", d.y+3).attr "id", d.name
		).on "mouseout", (d) =>
			d3.select("text").remove()

		nodeEnter.append("svg:circle").attr("r", 10).on "click", @clickNode


		# nodeEnter.append("svg:text").attr("x", (d) ->
		# 	(if d._children then -8 else 8)
		# ).attr("y", 3).text (d) ->
		# 	d.name


		nodeEnter.transition().duration(@duration).attr("transform", (d) ->
			"translate(" + d.x + "," + d.y + ")"
		).style("opacity", 1).select("circle").style("fill", (d) ->
			console.log (if d.children then "#f00" else "#fff")
			(if d.children then "#f66" else "#999")
		)

		node.transition().duration(@duration).attr("transform", (d) ->
			"translate(" + d.x + "," + d.y + ")"
		).style "opacity", 1
		node.exit().transition().duration(@duration).attr("transform", (d) ->
			"translate(" + source.x + "," + source.y + ")"
		).style("opacity", 1e-6).remove()


		# Update the links…
		link = @vis.selectAll("path.link").data(@tree.links(nodes), (d) ->
			d.target.id
		)

		# Enter any new links at the parent's previous position.
		link.enter().insert("svg:path", "g").attr("class", "link").attr("d", (d) =>
			o =
				x: source.x0
				y: source.y0

			@diagonal
				source: o
				target: o

		).transition().duration(@duration).attr "d", @diagonal

		# Transition links to their new position.
		link.transition().duration(@duration).attr "d", @diagonal

		# Transition exiting nodes to the parent's new position.
		link.exit().transition().duration(@duration).attr("d", (d) =>
			o =
				x: source.x
				y: source.y

			@diagonal
				source: o
				target: o

		).remove()

		# Stash the old positions for transition.
		nodes.forEach (d) ->
			d.x0 = d.x
			d.y0 = d.y

	updateV: (source) =>
		# Compute the new tree layout.
		nodes = @tree.nodes(@rootNode).reverse()

		# Update the nodes…
		node = @vis.selectAll("g.node").data(nodes, (d) =>
			d.id or (d.id = ++@i)
		)
		nodeEnter = node.enter().append("svg:g").attr("class", "node").attr("transform", (d) ->
			"translate(" + source.y0 + "," + source.x0 + ")"
		)

		nodeEnter.append("svg:circle").attr("r", 4.5).style("fill", (d) ->
			(if d._children then "lightsteelblue" else "#fff")
		).on "click", @clickNode


		nodeEnter.append("svg:text").attr("x", (d) ->
			(if d._children then -8 else 8)
		).attr("y", 3).text (d) ->
			d.name


		nodeEnter.transition().duration(@duration).attr("transform", (d) ->
			"translate(" + d.y + "," + d.x + ")"
		).style("opacity", 1).select("circle").style "fill", "lightsteelblue"
		node.transition().duration(@duration).attr("transform", (d) ->
			"translate(" + d.y + "," + d.x + ")"
		).style "opacity", 1
		node.exit().transition().duration(@duration).attr("transform", (d) ->
			"translate(" + source.y + "," + source.x + ")"
		).style("opacity", 1e-6).remove()


		# Update the links…
		link = @vis.selectAll("path.link").data(@tree.links(nodes), (d) ->
			d.target.id
		)

		# Enter any new links at the parent's previous position.
		link.enter().insert("svg:path", "g").attr("class", "link").attr("d", (d) =>
			o =
				x: source.x0
				y: source.y0

			@diagonal
				source: o
				target: o

		).transition().duration(@duration).attr "d", @diagonal

		# Transition links to their new position.
		link.transition().duration(@duration).attr "d", @diagonal

		# Transition exiting nodes to the parent's new position.
		link.exit().transition().duration(@duration).attr("d", (d) =>
			o =
				x: source.x
				y: source.y

			@diagonal
				source: o
				target: o

		).remove()

		# Stash the old positions for transition.
		nodes.forEach (d) ->
			d.x0 = d.x
			d.y0 = d.y

	clickNode: (d) =>
		if d.children
			d._children = d.children
			d.children = null
		else
			d.children = d._children
			d._children = null
		@updateFunc?(d)

	# Toggle children.
	toggleNode: (d) =>
		if d.children
			d._children = d.children
			d.children = null
		else
			d.children = d._children
			d._children = null

	toggleAll: (d) =>
		if d.children
			d.children.forEach @toggleAll
			@toggleNode d

