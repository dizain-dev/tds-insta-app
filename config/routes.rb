Rails.application.routes.draw do
  root 'page#index'
  post '/connect', to: 'page#connect'
  get '/callback', to: 'page#connect_callback'
  match '/result', to: 'page#taginfo', via: [:get, :post]
end
