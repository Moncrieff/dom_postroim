DomPostroim::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => 'devise/registrations' }

  devise_scope :user do
    match 'new/:role' => 'devise/registrations#new', :as => 'sign_up'
  end

  match 'jobs/:job_id/bids/:id/accept' => 'bids#accept', :as => 'accept_bid'

  resources :jobs do
    resources :comments, :only => [:new, :create]
    resources :bids, :only => [:new, :create]
    resources :ratings, :only => [:new, :create, :index]
    match 'complete' => 'jobs#complete'
  end

  root :to => 'jobs#index'
end
