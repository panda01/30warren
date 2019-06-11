Rails.application.routes.draw do

  without_tenant do
    get :colophon, to: 'colophon#show'
    get :contact, to: 'registrants#new'
    get :legal, to: 'legal#show'
    get :neighborhood, to: 'places#index'
    get :residences, to: 'residences#show'
    get :partners, to: 'partners#show'
    get :team, to: 'team_members#index'
    get :gallery, to: 'gallery#show'

    resources :units,       path: 'availability', only: [:index, :show]
    resources :registrants, path: 'contact',      only: [:create]
    resources :press_clippings, path: 'press',    only: [:index, :show]
  end

  admin_for :amenities
  admin_for :buyers
  admin_for :local_features
  admin_for :pages
  admin_for :places
  admin_for :press_clippings
  admin_for :registrants
  admin_for :sales_agents
  admin_for :team_members
  admin_for :units
  admin_for :unit_types
  admin_for :views

  namespace :admin do
    root to: 'registrants#index'
    get  'login',  to: 'sessions#new'
    post 'login',  to: 'sessions#create'
    get  'logout', to: 'sessions#destroy'
  end

  get 'login', to: redirect('/admin/login')
  post 'login',  to: 'sessions#create'
  get  'logout', to: 'sessions#destroy'

  with_tenant do
    root to: 'buyers#show', as: :tenant_root
  end

  root to: 'building#show'
  get :building, to: 'building#show'

end
