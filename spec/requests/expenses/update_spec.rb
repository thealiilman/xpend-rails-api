require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/api/expenses/{expense_id}' do
    put 'Update an expense' do
      tags 'Expenses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :expense_id, in: :path, type: :string, required: true

      parameter name: :expense, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          amount_cents: { type: :integer },
          amount_currency: { type: :string },
          user_id: { type: :integer },
          expense_category_id: { type: :integer }
        }
      }

      let(:user) { create(:user) }
      let(:expense_1) { create(:expense, user: user) }
      let(:expense_id) { expense_1.id }

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns updated expense' do
        let(:expense) do
          {
            title: build_stubbed(:expense).title
          }
        end

        run_test! do
          expect(json['data']['attributes']['title'])
            .to eq(expense[:title])
        end
      end

      response '422', 'returns unprocessable entity error' do
        let(:expense) do
          {
            title: ''
          }
        end

        run_test! do
          expect(json['error']['message']['title'].first)
            .to eq("can't be blank")
        end
      end
    end
  end
end
