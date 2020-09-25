require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/expenses/{expense_id}' do
    put 'Update an expense' do
      tags 'Expenses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

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

      let(:Authorization) do
        "Bearer #{JsonWebToken.generate(user.id).token}"
      end

      let(:user) { create(:user) }
      let(:expense_1) { create(:expense, user: user) }
      let(:expense_id) { expense_1.id }

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
