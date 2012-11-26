Graphcomposer::Application.routes.draw do

	root :to => "home#index"
	resources :layers
	match "/types" => "layers#types"

end
