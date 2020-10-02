require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/user' do
    put "Update user's given_name and email" do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_params, in: :body, schema: {
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
        }
      }

      let(:user_1) { create(:user, given_name: 'Ali') }

      before { access_and_refresh_tokens_cookies(user_1) }

      response '200', 'returns updated user' do
        let(:given_name) { 'Ali' }
        let(:email) { 'ali@example.com' }

        context 'when given_name is updated' do
          let(:user_params) do
            {
              user: {
                given_name: given_name,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['data']['attributes']['given_name']).to eq(given_name)
            expect(user_1.reload.given_name).to eq(given_name)
          end
        end

        context 'when email is updated' do
          let(:user_params) do
            {
              user: {
                email: email,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['data']['attributes']['email']).to eq(email)
            expect(user_1.reload.email).to eq(email)
          end
        end

        context 'when both given_name and email are updated' do
          let(:user_params) do
            {
              user: {
                given_name: given_name,
                email: email,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['data']['attributes']['email']).to eq(email)
            expect(json['data']['attributes']['given_name']).to eq(given_name)
            user_1.reload
            expect(user_1.reload.given_name).to eq(given_name)
            expect(user_1.reload.email).to eq(email)
          end
        end
      end

      response '400', 'returns invalid password error' do
        let(:user_params) do
          {
            user: {
              given_name: 'Ali',
              email: 'ali@example.com',
              password: 'wasspord'
            }
          }
        end

        run_test! do
          expect(json['error']['message']).to eq('Invalid password')
        end
      end

      response '422', 'returns error if value is not unique' do
        let(:user_2) do
          create(:user, given_name: 'Liam', email: 'liam@example.com')
        end

        context 'when email is not unique' do
          let(:user_params) do
            {
              user: {
                email: user_2.email,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['error']['message']['email'].first)
              .to eq('has already been taken')
            expect(user_1.reload.email).to eq(user_1.email)
          end
        end
      end
    end
  end
end
