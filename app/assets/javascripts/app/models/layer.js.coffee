class App.Layer extends Spine.Model
  @configure 'Layer', 'width', 'height', 'layer_width', 'layer_height', 'x', 'y', 'postiion', 'scale', 'blend', 'clones', 'name', 'file', 'alpha'
  @extend Spine.Model.Ajax

  @belongsTo 'layer_type', 'App.LayerType'

  @currentLayer = null
