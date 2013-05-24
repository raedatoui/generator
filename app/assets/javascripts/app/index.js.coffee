#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route
#= require spine/relation

#= require modernizr-2.6.2.min
#= require jquery_ujs
#= require exo
#= require exo.spine
#= require TweenMax.min
#= require spectrum
#= require hamlcoffee
#= require d3.min
#= require jquery.form.js

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller

	constructor: ->
		super
		App.LayerType.bind 'refresh', @typesLoaded
		App.LayerType.fetch()

	typesLoaded: =>
		App.Layer.one 'refresh', @layersLoaded
		App.Layer.fetch()

	layersLoaded: =>
		@visualizer = new App.Visualizer
		@append @visualizer
		@visualizer.bind "nodeSelected", (data) =>
			@tools.showInfo data

		@tools = new App.Tools
		@append @tools
		@tools.bind "moved", (w) =>
			@visualizer.slide w

window.App = App
