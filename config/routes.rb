Generator::Application.routes.draw do

  root :to => "home#index"

  match "/nested" => "layers#nested"

  resources :layer_types
  resources :layers



end
