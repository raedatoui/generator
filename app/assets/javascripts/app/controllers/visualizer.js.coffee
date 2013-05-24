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

		Spine.bind "dataAdded", (data) =>
			@keep_rendering()
			# @debounce()

	keep_rendering: =>
		@offset = 20
		@layoutMode = 'h'
		w = @el.width()
		h = @el.height()
		@i = 0
		@duration = 500
		@vis = d3.select("#mCanvas").append("svg:svg").attr("width", w).attr("height", h).append("svg:g").attr("transform", "translate(40,40)")
		d3.json "/nested.json", (json) =>
			@json_data = json
			json.x0 = 800
			json.y0 = 0
			@rootNode = json
			@setLayoutMode "h"

		gradient = @vis.append("svg:defs").append("svg:linearGradient")
			.attr("id", "gradient")
			.attr("x1", "0%")
			.attr("y1", "0%")
			.attr("x2", "100%")
			.attr("y2", "100%")
			.attr("spreadMethod", "pad")

		gradient.append("svg:stop").attr("offset", "0%").attr("stop-color", "#666").attr "stop-opacity", 1
		gradient.append("svg:stop").attr("offset", "100%").attr("stop-color", "#000").attr "stop-opacity", 1

		$(window).resize @debounce

	debounce: =>
		timeoutID = -1
		clearTimeout timeoutID  if timeoutID > -1
		timeoutID = setTimeout =>
			@setLayoutMode @layoutMode
		, 125

	toggleLayout: =>
		if @layoutMode is "h"
			@setLayoutMode "v"
		else
			@setLayoutMode "h"

	setLayoutMode: (mode) =>
		delay = false
		if @layoutMode != mode
			delay = true
			@clickNode @rootNode

		@layoutMode = mode
		w = $(window).width() - @offset
		h = $(window).height()
		@el.width w
		@el.height h
		d3.select("svg").attr("width", w).attr("height", h)
		@vis.attr("width", w).attr("height", h)

		if mode is "h"
			@tree = d3.layout.tree().size([w-40, h-80])
			@diagonal = d3.svg.diagonal().projection((d) ->
				[d.x, d.y]
			)
		else
			@tree = d3.layout.tree().size([h-40, w-240])
			@diagonal = d3.svg.diagonal().projection((d) ->
				[d.y, d.x]
			)
		if delay
			setTimeout =>
				@clickNode @rootNode
			, @duration*2
		else
			@update @rootNode

	slide: (w) =>
		@offset = w
		@setLayoutMode @layoutMode
		TweenLite.to @el, .5,
			css:
				left: w

	update: (source) =>
		# Compute the new tree layout.
		nodes = @tree.nodes(@rootNode).reverse()
		# Update the nodes…
		node = @vis.selectAll("g.node").data(nodes, (d) =>
			# if d.depth == 1
			# 	d.y = d.y*0.5
			d.id or (d.id = ++@i)
		)
		if @layoutMode is "h"
			# @vis.select("g.node").append("svg:circle").attr("fill", "#FC2B2B").attr("r", 10)
			# @vis.select("g.node rect").remove()
			# @vis.select("g.node text").remove()

			nodeEnter = node.enter().append("svg:g")
				.attr("class", "node")
				.attr("transform", (d) ->
					"translate(" + source.x0 + "," + source.y0 + ")"
				)

				.on("click", @clickNode)

				.on("mouseover", (d) =>
					d3.select("text.node").remove()
					d3.select("rect.node").remove()
					@vis.append("text").text(d.name).attr("x", d.x+20).attr("y", d.y+5).attr("id", d.name).attr("fill","#fff").attr("class","node")
					wi = parseInt(d3.select("text").style("width").split('px')[0]) + 8
					@vis.insert("svg:rect", "text").attr("x", d.x+16).attr("y", d.y-12).attr("width",wi).attr("height",24).style("fill", "url(#gradient)").attr("class","node")
				)
				.on("mouseout", (d) =>
					d3.select("text.node").remove()
					d3.select("rect.node").remove()
				)

			nodeEnter.append("svg:circle").attr("r", (d) =>
				if d.depth is 0
					@vis.append("text").text(d.name).attr("x", d.x+20).attr("y", d.y+5).attr("id", d.name).attr("fill","#fff").attr("class","root")
					wi = parseInt(d3.select("text").style("width").split('px')[0]) + 8
					@vis.insert("svg:rect", "text").attr("x", d.x+16).attr("y", d.y-12).attr("width",wi).attr("height",24).style("fill", "url(#gradient)").attr("class","root")

				if d.depth is 0 then 4 else 10
			)

			nodeEnter.transition().duration(@duration)
			.attr("transform", (d) ->
				"translate(" + d.x + "," + d.y + ")"
			)
			.style("opacity", 1).select("circle").style("fill", (d) ->
				(if d.children or (d.chidlren and d.children.length > 0) then "#FC2B2B" else "#767676")
			)

			node.transition().duration(@duration)
			.attr("transform", (d) ->
				"translate(" + d.x + "," + d.y + ")"
			)
			.style "opacity", 1

			node.exit().transition().duration(@duration)
			.attr("transform", (d) ->
				"translate(" + source.x + "," + source.y + ")"
			)
			.style("opacity", 1e-6).remove()

		else
			node.on("mouseover",null)
			d3.select("text.root").remove()
			d3.select("rect.root").remove()

			nodeEnter = node.enter().append("svg:g")
				.attr("class", "node")
				.attr("width",200).attr("height",24)
				.attr("transform", (d) ->
					"translate(" + source.y0 + "," + source.x0 + ")"
				)
				.on("click", @clickNode)

			nodeEnter.append("svg:rect")
				.attr("x", -50)
				.attr("y", -12)
				.attr("width",200)
				.attr("height",24).
				style("fill", "url(#gradient)")

			nodeEnter.append("text")
				.text( (d) ->
					d.name
				)
				.attr("x", -46)
				.attr("y", 4)
				.attr("fill","#fff")

			nodeEnter.transition().duration(@duration).attr("transform", (d) ->
				"translate(" + d.y + "," + d.x + ")"
			).style("opacity", 1).select("circle").style("fill", (d) ->
				(if d.children then "#f66" else "#999")
			)

			node.transition().duration(@duration).attr("transform", (d) ->
				"translate(" + d.y + "," + d.x + ")"
			).style "opacity", 1

			node.exit().on("mouseover",null).transition().duration(@duration).attr("transform", (d) ->
				"translate(" + source.y + "," + source.x + ")"
			).style("opacity", 1e-6).remove()

			@vis.select("g.node").on("mouseover",null)
			# @vis.select("g.node").append("svg:rect").attr("x", -20).attr("y", -12).attr("width",200).attr("height",24).style("fill", "url(#gradient)")
			# @vis.select("g.node").append("text").text(@rootNode.name)
			# 	.attr("x", -16)
			# 	.attr("y", 4)
			# 	.attr("fill","#fff")

		# Update the links…
		link = @vis.selectAll("path.link").data(@tree.links(nodes), (d) ->
			d.target.id
		)

		# Enter any new links at the parent's previous position.
		link.enter().insert("svg:path", "g").attr("class", "link")
			.attr("d", (d) =>
				o =
					x: source.x0
					y: source.y0

				@diagonal
					source: o
					target: o

			)
			.transition().duration(@duration).attr "d", @diagonal

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
		if d.depth != 0
			@trigger "nodeSelected", d
		if d.children
			d._children = d.children
			d.children = null
		else
			d.children = d._children
			d._children = null
		@update d

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

