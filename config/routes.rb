Rails.application.routes.draw do
  resources :observables
  resources :tickets do
      resources :attachments
      resources :comments
      resources :observables
      get :children
  end

  resources :incidents do
      member do
          get :tickets
          get :leads
      end
  end

  devise_for :users

  root :to => 'incidents#index'
end
