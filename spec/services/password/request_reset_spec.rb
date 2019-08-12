require 'rails_helper'

describe Password::RequestReset, type: :service do
  let(:user) { create(:user) }

  describe '.run' do
    subject { described_class.run(user) }
    it { should be_truthy }
  end
end
