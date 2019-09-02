Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    post 'login', to: 'authentications#login'
    post 'signup', to: 'users#create'

    post 'forgot_password', to: 'passwords#forgot'
    post 'reset_password', to: 'passwords#reset'

    resources :expenses, except: :show
    resources :expense_categories, only: :index
    resource :user, only: %i[show update destroy]
  end
end
