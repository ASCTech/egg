Egg::Application.routes.draw do
  post "/events" => "events#create"
  get "/events" => "events#index"
end
