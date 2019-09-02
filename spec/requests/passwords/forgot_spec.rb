require 'rails_helper'

describe Api::PasswordsController, type: :request do
  path '/forgot_password' do
    post 'User requests for a password reset' do
      tags 'Passwords'
      produces 'application/json'

      parameter name: :email, in: :query, type: :string, required: true

      let(:user) { create(:user) }

      response '200', 'user successfully requests for a password reset' do
        let(:email) { user.email }

        run_test! do
          user.reload
          expect(user.reset_password_digest).to be_truthy
          expect(user.reset_password_email_sent_at).to be_truthy
        end
      end

      response '404', 'returns error when user does not exist' do
        let(:email) { 'liamgallagher@example.com' }

        run_test! do
          expect(json['error']['message'])
            .to eq('User does not exist!')
        end
      end
    end
  end
end
