# encoding : utf-8

MoneyRails.configure do |config|
  # To set the default currency
  config.default_currency = :eur

  # Set default bank object
  config.default_bank = EuCentralBank.new

  # Set default raise_error_on_money_parsing option
  # It will be raise error if assigned different currency
  # The default value is false
  #
  # Example:
  # config.raise_error_on_money_parsing = false
end

rates = Rails.cache.fetch "money:eu_central_bank_rates", expires_in: 24.hours do
  Money.default_bank.save_rates_to_s
end
Money.default_bank.update_rates_from_s rates
