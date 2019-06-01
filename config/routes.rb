Rails.application.routes.draw do
  resources :tickets do
      resources :attachments
  end

  resources :incidents

  devise_for :users

  root :to => 'incidents#index'
end
