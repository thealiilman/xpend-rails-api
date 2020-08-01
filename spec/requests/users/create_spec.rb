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
              given_name: { type: :string },
              email: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: %w[given_name email password]
      }

      let(:user_1) { build_stubbed(:user) }

      response '201', 'returns the created user' do
        let(:user) do
          {
            user: {
              given_name: user_1.given_name,
              email: user_1.email,
              password: user_1.password
            }
          }
        end

        run_test! do
          expect(json['data']['attributes']['given_name']).to eq(user_1.given_name)
          expect(json['data']['attributes']['email']).to eq(user_1.email)
        end
      end

      response '422', 'returns unprocessable entity error' do
        let(:user) do
          {
            user: {
              given_name: user_1.given_name
            }
          }
        end

        run_test!
      end
    end
  end
end
