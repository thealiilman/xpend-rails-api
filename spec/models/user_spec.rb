require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { FactoryBot.create(:user) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
