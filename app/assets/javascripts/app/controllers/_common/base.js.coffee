class App.BaseController extends Exo.Spine.Controller

  resize: ->

  doActivate: ->
    @onActivated()


  doDeactivate: ->
    @el.remove()
    @onDeactivated()

  activateNext: (next) ->
    unless @next
      @next = next
      @addChild @next                     # Add the section to the controller hierarchy
      @next.bind "onDeactivated", @onControllerDeactivated  # Get notified when the controller is deactivated
      @next.bind "onActivated", @onControllerActivated    # and activated.
      @next.appendTo @container                    # Also append it's @el to the DOM.
      @next.activate()                    # Attempt to activate the section.

  onControllerActivated: (controller) =>
    @current = controller
    @next = null
    if @current.constructor.name is "LayerInfo"
      @current.prepareWithModel App.Layer.currentLayer

  onControllerDeactivated: (controller) =>
    @removeChild controller
    controller.release()
