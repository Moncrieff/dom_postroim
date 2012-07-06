DomPostroim::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    match 'tradesman/sign_up' => 'devise/registrations#new', :user => { :role => 'tradesman' }
  end

  resources :jobs
  root :to => 'jobs#index'
end
