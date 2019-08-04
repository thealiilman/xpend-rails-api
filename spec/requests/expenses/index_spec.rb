require 'rails_helper'

describe Api::ExpensesController, type: :request do
  path '/expenses' do
    get 'All expenses of the user' do
      tags 'Expenses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization',
                in: :header, type: :string, required: true

      let(:Authorization) do
        "Bearer #{KnockToken.generate(user.id).token}"
      end

      response '200', 'returns all expenses of the user' do
        let(:user) { create(:user) }
        before { create_list(:expense, 4, user: user) }

        run_test! do
          expect(json['data'].length).to eq(4)
        end
      end
    end
  end
end
