require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/user' do
    get 'Get user' do
      tags 'Users'
      produces 'application/json'

      let(:user) { create(:user) }
      let(:user_serializer) { UserSerializer.new(user) }

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns ok' do
        run_test! do
          expect(json).to eq(JSON.parse(user_serializer.to_json))
        end
      end
    end
  end
end
