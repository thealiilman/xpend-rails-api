require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/api/expenses/{expense_id}' do
    delete 'Destroy an expense' do
      tags 'Expenses'

      parameter name: :expense_id, in: :path, type: :string, required: true

      let(:user) { create(:user) }
      let(:expense) { create(:expense, user: user) }
      let(:expense_id) { expense.id }

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns ok' do
        run_test!
      end
    end
  end
end
