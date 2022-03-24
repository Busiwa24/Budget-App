Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  get 'welcome/info'
  get 'welcome/start'

  devise_scope :user do
    authenticated :user do
      root 'groups#index', as: :authenticated_root
    end
    unauthenticated { root 'welcome#index', as: :unauthenticated_root }
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :welcome, only: %i[index info start]
  resources :users, only: %i[show income update destroy]

  resources :groups, only: %i[index show new create destroy] do
    resources :entities, only: %i[index show new create destroy]
  end
end
