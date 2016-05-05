Rails.application.routes.draw do
  resources :posts
  devise_for :usuarios, controllers: {omniauth_callbacks: "omniauth_callbacks",
                                                           registrations: "registrations"}
  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  
end
