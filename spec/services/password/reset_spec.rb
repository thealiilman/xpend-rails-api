require 'rails_helper'

describe Password::Reset, type: :service do
  let(:user) { create(:user, :requested_password_reset) }

  describe '.run' do
    context 'unique password' do
      subject { described_class.run(user, 'wasspord').success? }
      it { should be_truthy }
    end

    context 'same password' do
      subject { described_class.run(user, user.password) }
      it do
        expect(subject.success?).to be_falsy
        expect(subject.error).to eq('Please use a unique password')
      end
    end
  end
end
