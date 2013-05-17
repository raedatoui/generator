class LayersController < ApplicationController

  respond_to :js, :json

  def show
    @layer = Layer.find(params[:id])
    render :json => @layer.to_json
  end

  def index
    root = Layer.find(:first, :conditions => ["ancestry is ?", nil])
    respond_with root.to_node
  end

  # def create
  #   @layer = Layer.new(params[:layer])
  #   @layer.save!

  #   #render :json => @layer
  # end

  # def create
  # respond_to do |format|
  #   format.json {respond_with @layer}
  #   format.js {respond_with @layer}
  #  end
  # end


  def types
    @types = LayerType.all
    respond_with @types
  end
end