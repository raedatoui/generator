class LayersController <  ApplicationController

  before_filter :load_layer_type, except: [:index, :nested]
  before_filter :load_layer, except: [:index, :create, :nested]

  respond_to :js, :json

  def index
    @layers = Layer.find(:all, :conditions => ["ancestry is not ?", nil])
    respond_with @layers
  end

  def show
    respond_with @layer.to_node
  end

  def update
    @layer.update_attributes layer_params
    respond_with @layer
  end

  def nested
    root = Layer.find(:first, :conditions => ["ancestry is ?", nil])
    respond_with root.to_node
  end

  def create
    @layer = @layer_type.layers.create layer_params
    respond_with @layer, location: layer_url(@layer, token: @layer_type.slug)
  end


  def destroy
    @layer.destroy
    head :ok
  end

  private

  def load_layer_type
    @layer_type = if params[:token] == 'layers'
      # TODO: This is only needed because Spine can't route saves properly
      LayerType.find params[:layer_type_id]
    else
      LayerType.find_by_slug params[:token]
    end
    raise ActionController::RoutingError.new('Not Found') unless @layer_type
  end

  def layer_params
    params.require(:layer).permit(:name, :file, *layer_type_attributes)
  end

  def load_layer
    @layer = @layer_type.layers.find params[:id]
  end

end
