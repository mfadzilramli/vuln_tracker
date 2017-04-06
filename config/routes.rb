Rails.application.routes.draw do

  get 'reports/generate'

  get 'tracking/index'

  devise_for :users, controllers: { registrations: 'registrations' }

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'registrations#update', :as => 'user_registration'
  end
  # post 'vulnerabilities/:host_id', to: 'vulnerabilities#create', as: 'create_vulnerability'
  get 'vulnerabilities/:id', to: 'vulnerabilities#show', as: 'show_vulnerability'
  get 'vulnerabilities/:host_id/new', to: 'vulnerabilities#new', as: 'new_vulnerability'

  # get 'vulnerabilities/:id', to: 'vulnerabilities#new', as: 'show_vulnerability'


  # get "affected_hosts/:source_id", to: "affected_hosts#index", as: "search_affected_hosts"
  get "affected_hosts/:project_group_id/show", to: "affected_hosts#show", as: "list_affected_hosts"
  get 'affected_hosts/:source_id/new', to: 'affected_hosts#new', as: 'new_affected_host'

  resources :vulnerabilities
  resources :affected_hosts
  resources :source_files
  resources :remedy_actions

  resources :project_groups do
    member do
      get 'search'
      get 'stats'
    end

    resources :affected_hosts do
      resources :vulnerabilities
      resources :reports do
        collection do
          get 'generate'
        end
      end
    end
  end

  resources :source_files do
    resources :affected_hosts
  end

  resources :reports do
    member do
      get 'search'
    end
    collection do
      get 'generate'
      get 'print_all'
    end
  end

get 'tracking', to: 'tracking#index', as: 'tracking'
post 'tracking/import', to: 'tracking#import', as: 'import_tracking'
  # get 'project_groups/:id/stats', to: 'project_groups#stats', as: 'stats_project_group'

  root 'project_groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
