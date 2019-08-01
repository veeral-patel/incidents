Rails.application.routes.draw do
  # resources :ticket_templates, :except => [:new, :show] do
  #   member do
  #     get :tree
  #   end
  # end

  resources :search, :only => [:index]

  resources :tickets, :except => [:edit, :new] do
      resources :attachments, :except => [:edit]
      resources :comments, :except => [:new, :edit]
      resources :observables, :except => [:edit]
      member do
        get :children
        get :tree
        # get :create_template
      end
  end

  get :assigned_tickets, :to => 'tickets#assigned_tickets'

  resources :incidents, :except => [:edit] do
      member do
          get :tickets
          get :leads
          get :observables
          get :attachments
          get :tree
          get :danger
          get :new_ticket
      end
      resources :members, only: [:index, :create, :destroy]
  end

  devise_for :users, :skip => [:registrations], controllers: { sessions: 'users/sessions' }

  # devise_scope :user do
  #   post "/users/sessions/verify_otp" => "users/sessions#verify_otp"
  # end

  # resources :two_factor, only: [:index] do
  #   collection do
  #     get :activate
  #     get :deactivate
  #   end
  # end

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
  end

  scope "/admin" do
    resources :users, :except => [:new, :show, :edit]
  end

  root :to => 'incidents#index'
end
