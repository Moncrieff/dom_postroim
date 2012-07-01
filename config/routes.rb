DomPostroim::Application.routes.draw do

  devise_for :users

  resources :jobs
  root :to => 'jobs#index'
end
