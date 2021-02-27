Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post 'login' => 'authentication#login'
    resources :issues, only: [:index, :show, :update]
    resources :user, only: [:index, :create, :update]
  end
end
