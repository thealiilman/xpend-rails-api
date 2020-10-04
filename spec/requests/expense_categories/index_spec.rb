require 'rails_helper'

describe Api::ExpenseCategoriesController, type: :request do
  path '/api/expense_categories' do
    get 'Fetch all expense categories' do
      tags 'Expense Categories'
      produces 'application/json'

      let(:user) { create(:user) }

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns all expense categories' do
        before { create_list(:expense_category, 4) }

        run_test! do
          expect(json['data'].length).to eq(4)
        end
      end
    end
  end
end
