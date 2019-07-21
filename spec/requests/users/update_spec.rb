require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/user' do
    put "Update user's username and email" do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

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
        }
      }

      let(:user_1) { create(:user, username: 'thealiilman') }
      let!(:user_2) do
        create(:user, username: 'liamgallagher', email: 'liam@example.com')
      end
      let(:Authorization) { "Bearer #{KnockToken.generate(user_1.id).token}" }

      response '200', 'returns updated user' do
        let(:username) { 'ali' }
        let(:email) { 'ali@example.com' }

        context 'when username is updated' do
          let(:user) do
            {
              user: {
                username: username,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['data']['attributes']['username']).to eq(username)
            expect(user_1.reload.username).to eq(username)
          end
        end

        context 'when email is updated' do
          let(:user) do
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

        context 'when both username and email are updated' do
          let(:user) do
            {
              user: {
                username: username,
                email: email,
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['data']['attributes']['email']).to eq(email)
            expect(json['data']['attributes']['username']).to eq(username)
            user_1.reload
            expect(user_1.reload.username).to eq(username)
            expect(user_1.reload.email).to eq(email)
          end
        end
      end

      response '400', 'returns invalid password error' do
        let(:user) do
          {
            user: {
              username: 'ali',
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
        context 'when username is not unique' do
          let(:user) do
            {
              user: {
                username: 'LiamGallagher',
                password: 'password'
              }
            }
          end

          run_test! do
            expect(json['error']['message']['username'].first)
              .to eq('has already been taken')
            expect(user_1.reload.username).to eq(user_1.username)
          end
        end

        context 'when email is not unique' do
          let(:user) do
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
