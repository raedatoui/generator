class App.Layer extends Spine.Model
  @configure 'Layer', 'width', 'height', 'layer_width', 'layer_height', 'x', 'y', 'postiion', 'scale', 'blend', 'clones', 'name', 'file', 'alpha', 'parent_id'
  @extend Spine.Model.Ajax

  @belongsTo 'layer_type', 'App.LayerType'

  @hasMany 'layers', 'App.Layer'

  @currentLayer = null

  # @url = "/nested"
