Rails.application.routes.draw do
  devise_for :user, skip: :all

  namespace :api, defaults: { format: :json } do
    post 'login' => 'authentication#login'
    resources :issues, only: [:index, :show, :update]
    post 'sign_up' => 'authentication#create'
  end
end
