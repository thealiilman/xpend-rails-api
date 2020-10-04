require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/api/user' do
    delete 'Deactivate user account' do
      tags 'Users'

      let(:user) { create(:user) }

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns ok' do
        run_test!
      end
    end
  end
end
