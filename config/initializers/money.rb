# encoding : utf-8

MoneyRails.configure do |config|
  config.default_bank = EuCentralBank.new
  config.default_currency = :eur
  config.locale_backend = :i18n
  config.rounding_mode = BigDecimal::ROUND_HALF_EVEN

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
