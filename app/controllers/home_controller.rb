class HomeController < ApplicationController
	respond_to :js, :json
  def index
	end
  def types
    @types = LayerType.all
    respond_with @types
  end

end
