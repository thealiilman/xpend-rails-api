require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/expenses/{expense_id}' do
    delete 'Destroy an expense' do
      tags 'Expenses'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true
      parameter name: :expense_id, in: :path, type: :string, required: true

      let(:Authorization) { "Bearer #{JsonWebToken.generate(user.id).token}" }
      let(:user) { create(:user) }
      let(:expense) { create(:expense, user: user) }
      let(:expense_id) { expense.id }

      response '200', 'returns ok' do
        run_test!
      end
    end
  end
end
