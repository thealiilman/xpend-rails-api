require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/expenses' do
    post 'Create an expense' do
      tags 'Expenses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

      parameter name: :expense, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          amount_cents: { type: :integer },
          amount_currency: { type: :string },
          user_id: { type: :integer },
          expense_category_id: { type: :integer }
        },
        required: %i[title amount_cents user_id expense_category_id]
      }

      let(:Authorization) do
        "Bearer #{KnockToken.generate(user.id).token}"
      end

      response '201', 'returns created expense' do
        let(:user) { create(:user) }
        let(:expense_category) { create(:expense_category) }
        let(:expense) do
          build(:expense, user: user, expense_category: expense_category)
        end

        run_test! do
          data = json['data']['attributes']
          expect(data['title']).to eq(expense.title)
          expect(data['description']).to eq(expense.description)
          expect(data['amount_cents']).to eq(expense.amount_cents)
          expect(data['amount_currency']).to eq(expense.amount_currency)
          expect(data['user_id']).to eq(expense.user_id)
          expect(data['expense_category']['data']['attributes']['title'])
            .to eq(expense_category.title)
        end
      end

      response '422', 'returns unprocessable entity error' do
        let(:user) { create(:user) }
        let(:expense) do
          {
            title: build_stubbed(:expense).title
          }
        end

        run_test!
      end
    end
  end
end
