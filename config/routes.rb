Rails.application.routes.draw do

  get 'reports/generate'

  get 'tracking/index'

  devise_for :users, controllers: { registrations: 'registrations' }

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'registrations#update', :as => 'user_registration'
  end

  # get 'vulnerabilities/:id', to: 'vulnerabilities#show', as: 'show_vulnerability'
  # get 'vulnerabilities/:host_id/new', to: 'vulnerabilities#new', as: 'new_vulnerability'
  get 'affected_hosts/:project_group_id/show', to: 'affected_hosts#show', as: 'list_affected_hosts'
  get 'affected_hosts/:source_id/new', to: 'affected_hosts#new', as: 'new_affected_host'

  # resources :vulnerabilities
  resources :affected_hosts
  resources :source_files
  resources :remedy_actions

  resources :project_groups do
    member do
      get 'search'
      get 'stats'
    end

    resource :report do
      collection do
        post 'generate_custom'
      end
    end

    resources :affected_hosts do
      resources :vulnerabilities do
        member do
          get 'duplicate'
        end
        resource :remedy_actions
      end
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

    collection do
      get 'generate'
      get 'generate_all'

      get ':project_group_id/clear_selection', to: 'reports#clear_selection', as: 'clear_selection'
      get ':project_group_id/custom', to: 'reports#custom', as: 'custom'
      get ':project_group_id/search', to: 'reports#search', as: 'search'

      # ajax request action for report item selection
      post ':project_group_id/insert/:affected_host_id', to: 'reports#insert', as: 'insert'
      post ':project_group_id/delete/:affected_host_id', to: 'reports#delete', as: 'delete'

      # custom report
      post 'generate_custom'
    end

  end

  get 'tracking', to: 'tracking#index', as: 'tracking'
  post 'tracking/import', to: 'tracking#import', as: 'import_tracking'

  root 'project_groups#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
