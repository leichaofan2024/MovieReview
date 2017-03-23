Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :movies do
    resources :reviews
    member do
      post :join_to_favorite
      post :quite_favorite
    end 
  end
end
