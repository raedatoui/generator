class LayerTypesController <  ApplicationController

  respond_to :js, :json

  def index
    @layer_types = LayerType.all
    respond_with @layer_types
  end

end