require 'api_version'

PQRST::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions" }

 resources :complaints


# This is so that api.pqrstpain.com works as domain, lets us version sessions api
scope defaults: { format: 'json' } do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      resources :mcomplaints
      resources :sessions
    end
end

# This fixes web login error
 devise_scope :user do 
    match '/sessions/user', to: 'devise/sessions#create', via: :post
 end

  resources :users
end

