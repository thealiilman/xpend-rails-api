require 'rails_helper'

describe Api::UsersController, type: :request do
  path '/user' do
    delete 'Deactivate user account' do
      tags 'Users'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

      let(:user) { create(:user) }

      response '200', 'returns ok' do
        let(:Authorization) { "Bearer #{KnockToken.generate(user.id).token}" }

        run_test!
      end
    end
  end
end
