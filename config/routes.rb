Rails.application.routes.draw do
  # post 'vulnerabilities/:host_id', to: 'vulnerabilities#create', as: 'create_vulnerability'
  get 'vulnerabilities/:id', to: 'vulnerabilities#show', as: 'show_vulnerability'
  get 'vulnerabilities/:host_id/new', to: 'vulnerabilities#new', as: 'new_vulnerability'

  # get 'vulnerabilities/:id', to: 'vulnerabilities#new', as: 'show_vulnerability'


  get "affected_hosts/:source_id", to: "affected_hosts#index", as: "search_affected_hosts"
  get "affected_hosts/:plugin_id/show", to: "affected_hosts#show", as: "list_affected_hosts"
  get 'affected_hosts/:source_id/new', to: 'affected_hosts#new', as: 'new_affected_host'

  resources :vulnerabilities
  resources :affected_hosts
  resources :source_files
  resources :project_groups
  resources :remedy_actions

  get 'project_groups/:id/stats', to: 'project_groups#stats', as: 'stats_project_group'

  root 'project_groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
