require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/signup' do
    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: %w[username email password]
      }

      let(:user_1) { build_stubbed(:user) }

      response '201', 'returns the created user' do
        let(:user) do
          {
            user: {
              username: user_1.username,
              email: user_1.email,
              password: user_1.password
            }
          }
        end

        run_test! do
          expect(json['data']['attributes']['username']).to eq(user_1.username)
          expect(json['data']['attributes']['email']).to eq(user_1.email)
        end
      end

      response '422', 'returns unprocessable entity error' do
        let(:user) do
          {
            user: {
              username: user_1.username
            }
          }
        end

        run_test!
      end
    end
  end
end
