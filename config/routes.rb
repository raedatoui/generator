Generator::Application.routes.draw do

	root :to => "home#index"
	resources :layers
	match "/nested" => "layers#nested"
	match "/types" => "layers#types"

end
