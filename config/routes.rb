Egg::Application.routes.draw do

  post "/events" => "events#create"
  get "/events" => "events#index"
  root :to => "services#show"

  resources :services, :only => [:show]
  resources :measureables, :only => [:show]
end
