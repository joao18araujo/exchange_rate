class BrlExchangeRatesController < ApplicationController

  def index
    @brl_exchange_rates = BrlExchangeRate.all

    minimum = @brl_exchange_rates.min_by { |x| x.value }
    maximum = @brl_exchange_rates.max_by { |x| x.value }
    @minimum_exchange_rate = minimum.value.round(4)
    @maximum_exchange_rate = maximum.value.round(4)
    @minimum_date = minimum.date.strftime('%d/%m/%Y')
    @maximum_date = maximum.date.strftime('%d/%m/%Y')

    exchange_rates = @brl_exchange_rates - [@brl_exchange_rates.first, @brl_exchange_rates.last]
    unless exchange_rates.empty?
      @average_rate = (exchange_rates.inject(0) { |sum, x| sum + x.value} / exchange_rates.size())
    else
      @average_rate = 0
    end

    @average_rate = @average_rate.round(4)
  end

end
