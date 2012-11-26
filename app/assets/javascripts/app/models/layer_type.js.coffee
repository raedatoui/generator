class App.LayerType extends Spine.Model
  @configure 'LayerType', 'id', 'name'
  @extend Spine.Model.Ajax

  @url = "/types"