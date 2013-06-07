class LayersController <  ApplicationController

  before_filter :load_layer_type, only: [:create]
  before_filter :load_layer, only: [:show, :update]
  before_filter :load_parent_layer, only: [:create, :update]

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
    @layer.update_attribute :parent, @parent_layer
    respond_with @layer
  end

  def nested
    root = Layer.find(:first, :conditions => ["ancestry is ?", nil])
    respond_with root.to_node
  end

  def create
    @layer = @layer_type.layers.create layer_params
    @layer.update_attribute :parent, @parent_layer
    respond_with @layer, location: layer_url(@layer, token: @layer_type.slug)
  end


  def destroy
    @layer.destroy
    head :ok
  end

  private

  def load_layer_type
    @layer_type = LayerType.find params[:layer][:layer_type_id]
    raise ActionController::RoutingError.new('Not Found') unless @layer_type
  end

  def load_layer
    @layer =  Layer.find params[:id]
  end

  def load_parent_layer
    @parent_layer = Layer.find params[:layer][:parent_id]
  end

  def layer_params
    params.require("layer").permit(:name, :file, :layer_type_id)
  end


end
