class HomeController < ApplicationController
	respond_to :js, :json

  def index
		# @layers = Layer.find(:all, :conditions => ["ancestry is not ?", nil])
  #   respond_with @layers
	end

  def types
    @types = LayerType.all
    respond_with @types
  end

end
