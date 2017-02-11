Rails.application.routes.draw do
  get 'vulnerabilities/:id', to: 'vulnerabilities#show', as: 'show_vulnerability'
  get 'vulnerabilities/:source_id/new', to: 'vulnerabilities#new', as: 'new_vulnerability'
  post 'vulnerabilities/:id', to: 'vulnerabilities#create'
  # get 'vulnerabilities/:id', to: 'vulnerabilities#new', as: 'show_vulnerability'

  get "affected_hosts/:source_id", to: "affected_hosts#index", as: "search_affected_hosts"

  resources :source_files
  resources :affected_hosts
  # resources :vulnerabilities

  root 'source_files#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
