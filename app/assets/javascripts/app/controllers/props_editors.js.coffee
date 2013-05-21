class App.PropsEditor extends Exo.Spine.Controller

	className: "props"

	events:
		"click #cancel" : "deactivate"
		"submit form": "save"

	elements:
		"form" : "form"
		"#status" : "status"
		'.percent': 'percent'
		'.progressBar' : 'bar'
		'#subBtn' : "submitBtn"

	prepareWithModel: (item) =>
		@el.empty()
		@item = item
		@render()
		# $("form input").live "change", ->
		# 	$(this).parents("form:first").submit()

	render: =>
		@html @view("editors/#{@item.slug}_editor",@item)
		setTimeout =>
			@keep_rendering()
		, 250

	keep_rendering: =>
		if $("#picker").length > 0
			$("#picker").spectrum
				preferredFormat: "hex6"
				showInput: true

		@form.ajaxForm
			dataType:  'json'
			beforeSend: =>
				@submitBtn.attr
				percentVal = "0%"
				@bar.width percentVal
				@percent.html percentVal

			uploadProgress: (event, position, total, percentComplete) =>
				percentVal = percentComplete + "%"
				@bar.width percentVal
				@percent.html percentVal

			complete: (xhr) =>
				layer = new App.Layer
				attr = JSON.parse xhr.responseText
				# layer.updateAttributes attr
				console.log layer,attr
				Spine.trigger "dataAdded", attr
				#layer.save()

	doActivate: ->
		TweenLite.to @el, 1,
			css:
				autoAlpha: 1
			onComplete: =>
				@onActivated()

	doDeactivate: ->
		TweenLite.to @el, 1,
			css:
				autoAlpha: 0
			onComplete: =>
				@onDeactivated()

	save: (e) =>
		console.log e
		e.preventDefault()

		#e.stopPropagration()
		# workaround way, submitting directly  -- cant see to be able to serialze file, and works wit remotipart, but that leads to 2 uploads
		# $.ajax
		# 	url: "/layers"
		# 	type: 'POST'
		# 	data: @form.serialize()
		# .done (response) =>
		# 	console.log response


		#SPine way -- doesnt work, no file serialization
		# layer =  new App.Layer
		# layer.fromForm(@form)
		# console.log layer
		# layer.save()
