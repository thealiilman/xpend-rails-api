require 'rails_helper'

describe Api::AuthenticationsController, type: :request do
  path '/login' do
    post 'Create a JSON Web Token for the user' do
      tags 'Authentications'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w[email password]
          }
        }
      }

      let(:user) { create(:user) }

      response '200', 'Stores access and refresh tokens in cookies' do
        let(:user_params) do
          {
            user: {
              email: user.email,
              password: user.password
            }
          }
        end

        run_test! do
          expect(response.cookies['access_token']).to be_present
          expect(response.cookies['refresh_token']).to be_present
          expect(user.reload.session_id).to be_present
        end
      end

      response '400', 'Returns user credentials are invalid error' do
        let(:user_params) do
          {
            user: {
              email: user.email,
              password: 'wasspord'
            }
          }
        end

        run_test! do
          expect(json['error']['message']).to eq('User credentials are invalid')
          expect(response.cookies['access_token']).to_not be_present
          expect(response.cookies['refresh_token']).to_not be_present
          expect(user.reload.session_id).to be_nil
        end
      end
    end
  end
end
