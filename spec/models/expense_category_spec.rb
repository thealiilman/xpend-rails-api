require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  describe 'associations' do
    it { should have_many(:expenses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end
end
