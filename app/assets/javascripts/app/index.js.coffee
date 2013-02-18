#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require jquery_ujs
#= require exo/exo
#= require TweenMax.min
#= require spectrum
#= require hamlcoffee

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
		App.Layer.bind 'refresh', @layersLoaded
		App.Layer.fetch()

	layersLoaded: =>
		@visualizer = new App.Visualizer
		@append @visualizer

		@tools = new App.Tools
		@append @tools

window.App = App