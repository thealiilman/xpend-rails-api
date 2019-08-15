require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:expenses) }
  end

  describe 'validations' do
    subject { FactoryBot.create(:user) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it do
      should validate_length_of(:username)
        .is_at_least(2).is_at_most(16)
    end

    it { should allow_value('thealiilman').for(:username) }
    it { should allow_value('THEALIILMAN').for(:username) }
    it { should allow_value('tHeAlIiLmAn19').for(:username) }
    it { should allow_value('oasis1994').for(:username) }
    it { should allow_value('Oasis1994').for(:username) }
    it { should_not allow_value('the-aliilman!').for(:username) }
  end
end
