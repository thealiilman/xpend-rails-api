Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    post 'login', to: 'authentications#login'
    post 'signup', to: 'users#create'

    resources :expenses, except: :show
    resource :user, only: %i[show update destroy]
  end
end
