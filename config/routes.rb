Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "repositories#index"
  get "/repositories", to: "repositories#index"
end
