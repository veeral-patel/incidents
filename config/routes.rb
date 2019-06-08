Rails.application.routes.draw do
  resources :tickets do
      resources :attachments
      resources :comments
      resources :observables
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
