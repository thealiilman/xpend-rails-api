Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    post 'login', to: 'authentications#login'
    resource :user, only: %i[create show update destroy]
  end
end
