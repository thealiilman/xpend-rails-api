require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/expenses' do
    get 'All expenses of the user' do
      tags 'Expenses'
      produces 'application/json'

      parameter name: :currency, in: :query, type: :string, required: false,
                enum: Money::Currency.table.keys.map(&:to_s).map(&:upcase)

      before { access_and_refresh_tokens_cookies(user) }

      response '200', 'returns all expenses of the user' do
        let(:user) { create(:user) }
        before { create_list(:expense, 4, user: user) }

        context 'without currency parameter' do
          run_test! do
            expect(json['data'].length).to eq(4)
          end
        end

        context 'with currency parameter' do
          let(:currency) { 'GBP' }

          run_test! do
            data = json.deep_symbolize_keys[:data]
            expect(data.pluck(:attributes).pluck(:amount_currency).uniq)
              .to match_array([currency])

            expect(data.pluck(:attributes).pluck(:amount).uniq)
              .to match_array([Expense.last.amount.exchange_to(currency).to_f])
          end
        end
      end
    end
  end
end
