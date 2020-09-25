require 'rails_helper'

describe Api::ExpenseCategoriesController, type: :request do
  path '/expense_categories' do
    get 'Fetch all expense categories' do
      tags 'Expense Categories'
      produces 'application/json'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

      let(:user) { create(:user) }
      let(:Authorization) do
        "Bearer #{JsonWebToken.generate(user.id).token}"
      end

      response '200', 'returns all expense categories' do
        before { create_list(:expense_category, 4) }

        run_test! do
          expect(json['data'].length).to eq(4)
        end
      end
    end
  end
end
