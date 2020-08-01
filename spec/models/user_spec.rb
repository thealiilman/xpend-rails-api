require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:expenses) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:user) }
    it { should validate_presence_of(:given_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
