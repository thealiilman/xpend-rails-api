require 'rails_helper'

describe Api::AuthenticationsController, type: :request do
  path '/login' do
    post 'Create a JSON Web Token for the user' do
      tags 'Authentications'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              password: { type: :string }
            }
          }
        },
        required: %w[username password]
      }

      let!(:user_1) { create(:user, username: 'thealiilman') }

      response '201', 'creates a JSON Web Token for the user' do
        let(:user) do
          {
            user: {
              username: user_1.username,
              password: user_1.password
            }
          }
        end

        run_test! do
          expect(json).to include('jwt')
        end
      end

      response '400', 'returns user credentials are invalid error' do
        let(:user) do
          {
            user: {
              username: user_1.username,
              password: 'wasspord'
            }
          }
        end

        run_test! do
          expect(json['error']['message']).to eq('User credentials are invalid')
        end
      end
    end
  end
end
