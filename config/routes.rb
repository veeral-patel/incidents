Rails.application.routes.draw do
  resources :tickets
  resources :incidents
  devise_for :users

  root :to => 'incidents#index'
end
