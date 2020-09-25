require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/user' do
    get 'Get user' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization',
                in: :header, type: :string, required: true

      let(:user) { create(:user) }
      let(:user_serializer) { UserSerializer.new(user) }

      response '200', 'returns ok' do
        let(:Authorization) { "Bearer #{JsonWebToken.generate(user.id).token}" }

        run_test! do
          expect(json).to eq(JSON.parse(user_serializer.to_json))
        end
      end
    end
  end
end
