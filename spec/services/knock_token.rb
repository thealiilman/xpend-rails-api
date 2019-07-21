require 'rails_helper'

describe KnockToken, type: :service do
  let(:user) { create(:user) }

  describe '.generate' do
    subject { JSON.parse(described_class.generate(user.id).to_json) }
    it { should include('jwt') }
  end
end
