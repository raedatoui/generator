class App.Layer extends Spine.Model
  @configure 'Layer', 'id', 'width', 'height', 'layer_width', 'layer_height', 'x', 'y', 'postiion', 'scale', 'blend', 'clones', 'name', 'layer_type_id'
  @extend Spine.Model.Ajax

  #@belongsTo 'layer_type_id', 'LayerType'