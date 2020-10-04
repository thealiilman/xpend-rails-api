require 'rails_helper'

describe Api::PasswordsController, type: :request do
  path '/api/reset_password' do
    post 'User resets their password' do
      tags 'Passwords'
      produces 'application/json'

      parameter name: :new_password,
                in: :query, type: :string, required: true
      parameter name: :reset_password_digest,
                in: :query, type: :string, required: true

      response '200', 'resets password of the user' do
        let(:user) { create(:user, :requested_password_reset) }
        let(:new_password) { 'wasspord' }
        let(:reset_password_digest) { user.reset_password_digest }

        run_test! do
          user.reload
          expect(user.reset_password_digest).to be_nil
          expect(user.reset_password_email_sent_at).to be_nil
        end
      end

      response '400', 'returns error' do
        context 'did not request for reset' do
          let(:user) { create(:user) }
          let(:new_password) { 'wasspord' }
          let(:reset_password_digest) { SecureRandom.urlsafe_base64 }

          run_test! do
            expect(json['error']['message'])
              .to eq('User did not request for a reset!')
          end
        end

        context 'returns error if new password is not unique' do
          let(:user) { create(:user, :requested_password_reset) }
          let(:new_password) { user.password }
          let(:reset_password_digest) { user.reset_password_digest }

          run_test! do
            expect(json['error']['message'])
              .to eq('Please use a unique password')
          end
        end
      end
    end
  end
end
