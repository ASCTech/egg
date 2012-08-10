Egg::Application.routes.draw do
  post "/events/put" => "events#create"
end
