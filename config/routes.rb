Egg::Application.routes.draw do
  get "services/show"

  post "/events" => "events#create"
  get "/events" => "events#index"
  root :to => "services#show"
end
