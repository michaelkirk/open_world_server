OpenWorldServer::Application.routes.draw do
  resources :points do
    resources :payloads
  end
end
