Graphcomposer::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

	root :to => "home#index"
	resources :layers
	match "/types" => "layers#types"

end
