DomPostroim::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'devise/registrations' }

  devise_scope :user do
    match 'new/:role' => 'devise/registrations#new', :as => 'sign_up'
  end

  resources :jobs
  root :to => 'jobs#index'
end
