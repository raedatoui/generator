Graphcomposer::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

	root :to => "home#index"
	resources :layers
	match "/nested" => "layers#nested"
	match "/types" => "layers#types"

end
