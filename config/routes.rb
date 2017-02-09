Rails.application.routes.draw do
  get 'vulnerabilities/:id', to: 'vulnerabilities#show', as: 'show_vulnerability'

  resources :affected_hosts
  resources :source_files
  root 'source_files#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
