Rails.application.routes.draw do
  resources :tickets, :except => [:edit] do
      resources :attachments
      resources :comments
      resources :observables, :except => [:edit]
      member do
        get :children
        get :tree
      end
  end

  resources :incidents, :except => [:edit] do
      member do
          get :tickets
          get :leads
          get :observables
          get :attachments
          get :tree
      end
  end

  devise_for :users

  root :to => 'incidents#index'
end
