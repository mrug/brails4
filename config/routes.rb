Brails::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#dashboard'

  namespace :admin do
    
    resources :levels, shallow: true do
      resources :questions
      resources :topics, shallow: true do
        resources :questions
        resources :contents, shallow: true do
          resources :questions
        end
      end
    end

    resources :users do
      resources :invitations, except: [:new, :create]
      resources :achievements, only: [:index, :show]
      resources :attempts, only: [:index, :show]
    end

    resources :feedbacks, only: [:index, :show]
  end

  resources :levels, only: [:show, :index] do
    resources :comments
    resources :questions, only: [:answer]
  end

  resources :topics, only: [:show, :index] do
    resources :comments
    resources :questions, only: [:show, :index, :answer]
  end

  resources :contents, only: [:show, :index] do
    resources :comments
  end

  resources :questions, only: [:show] do
    resources :comments
    post '/attempt/:option_id', to: 'attempts#create'
  end

  resources :users, only: [:show,:edit,:update] do
    resources :invitations, only: [:new, :create]
    resources :achievements, only: [:index, :show]
    resources :profiles
  end
  resources :feedbacks, only: [:new, :create]
end