Clouddevelopmentresearch::Application.routes.draw do
  get "accounts/index"

  get "accounts/new"

  get "accounts/search"
  match "/accounts/:id", to: "accounts#show", as: "account"

  get "accounts/create"

  get "accounts/show"
  
  resources :accounts
  root :to => "accounts#index"
end
