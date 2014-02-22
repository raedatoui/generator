class App.LayerType extends Spine.Model
  @configure 'LayerType', 'id', 'name','icon'
  @extend Spine.Model.Ajax

  @url = "/layer_types"

  @hasMany 'layers', 'App.Layer'
