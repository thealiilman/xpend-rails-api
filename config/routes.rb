Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  namespace :api do
    resource :user, only: %i[create show update destroy]
  end
end
