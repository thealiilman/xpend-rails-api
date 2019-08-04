require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:description).is_at_most(200) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
