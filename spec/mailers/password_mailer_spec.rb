require 'rails_helper'

describe PasswordMailer, type: :mailer do
  let(:user) { create(:user) }

  describe '.request_for_a_reset' do
    subject(:mail) { described_class.request_for_a_reset(user) }

    it do
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq('Instructions to reset your password')
    end
  end
end
