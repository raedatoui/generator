class App.LayerType extends Spine.Model
  @configure 'LayerType', 'id', 'name','icon'
  @extend Spine.Model.Ajax

  @url = "/types"

  @hasMany 'layers', 'App.Layer'
