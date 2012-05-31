Clouddevelopmentresearch::Application.routes.draw do
  
  resources :accounts
  get "accounts/index"

  get "accounts/new"

  get "accounts/search"
  match "/accounts/:id", to: "accounts#show", as: "account"

  get "accounts/create"

  get "accounts/show"
  
  get "accounts/edit"
  
  root :to => "accounts#index"
end
