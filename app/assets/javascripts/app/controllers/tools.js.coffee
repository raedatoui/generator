class App.Tools extends App.BaseController

    className: "tools"

    elements:
        ".bar" : "bar"
        ".toggle" : "toggleBtn"
        ".actions" : "actionsPanel"
        "#add" : "addButton"
        "#delete" : "deleteButton"
        "#info" : "infoButton"
        ".actions" : "container"

    events:
        "click .bar": "togglePanel"
        # "click #add" : "showCreator"

    panelClosed = true
    # select, info / props - update, add, delete

    constructor: ->
        super
            initialState: Exo.Node.States.ACTIVATED

        panelClosed = true

        @routes
            '/new/:type': (params) ->
                console.log "yooo"
                @deleteButton.hide()
                @infoButton.hide()
                $('.button').removeClass "selected"
                if @current is undefined or @current.constructor.name != "LayerCreator"
                    creator = new App.LayerCreator
                    creator.bind "closed", @selectionMade
                    @activateNext creator
                    @addButton.addClass "selected"

            '/edit/:id': (params) ->
                console.log params
                @deleteButton.show()
                @infoButton.show()
                if panelClosed
                    @togglePanel()
                $('.button').removeClass "selected"
                @infoButton.addClass "selected"

                App.Layer.currentLayer = App.Layer.find(params.id)
                if @current && @current.constructor.name  is "LayerInfo"
                    @current.prepareWithModel App.Layer.currentLayer
                else
                    props = new App.LayerInfo
                    @activateNext props


        @render()

    render: =>
        @html @view("tools")
        @deleteButton.hide()
        @infoButton.hide()

    togglePanel: =>
        if panelClosed
            @trigger "moved", 342
            TweenLite.to @el, .5,
                css:
                    left: 0
                onComplete: =>
                    panelClosed = false
                    @toggleBtn.removeClass("ui-bar-open").addClass("ui-bar-close")
        else
            @trigger "moved", @bar.width()
            TweenLite.to @el, .5,
                css:
                    left: -@el.width() + @bar.width()
                onComplete: =>
                    panelClosed = true
                    @toggleBtn.removeClass("ui-bar-closed").addClass("ui-bar-open")

    # showCreator: =>
    #   @deleteButton.hide()
    #   @infoButton.hide()
    #   $('.button').removeClass "selected"
    #   if @current is undefined or @current.constructor.name != "LayerCreator"
    #       creator = new App.LayerCreator
    #       creator.bind "closed", @selectionMade
    #       @activateNext creator
    #       @addButton.addClass "selected"

    # showInfo: (data) =>
    #   console.log data
    #   @deleteButton.show()
    #   @infoButton.show()
    #   if panelClosed
    #       @togglePanel()
    #   $('.button').removeClass "selected"
    #   @infoButton.addClass "selected"

    #   App.Layer.currentLayer = App.Layer.find(data.id)
    #   if @current && @current.constructor.name  is "LayerInfo"
    #       @current.prepareWithModel App.Layer.currentLayer
    #   else
    #       props = new App.LayerInfo
    #       @activateNext props

    selectionMade: =>
        @addButton.removeClass "selected"


