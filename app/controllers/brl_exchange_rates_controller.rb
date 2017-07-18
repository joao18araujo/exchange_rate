class BrlExchangeRatesController < ApplicationController

  def index
    @brl_exchange_rates = BrlExchangeRate.all.sort_by {|x| x.date}

    @total_of_days = Date.parse('2011-11-17') - Date.parse('2009-08-07')  + 1

    unless @brl_exchange_rates.empty?
      @initial_date = @brl_exchange_rates.first.date.strftime('%d/%m/%Y')
      @final_date = @brl_exchange_rates.last.date.strftime('%d/%m/%Y')

      minimum = @brl_exchange_rates.min_by { |x| x.value }
      maximum = @brl_exchange_rates.max_by { |x| x.value }
      @minimum_exchange_rate = minimum.value.round(4)
      @maximum_exchange_rate = maximum.value.round(4)
      @minimum_date = minimum.date.strftime('%d/%m/%Y')
      @maximum_date = maximum.date.strftime('%d/%m/%Y')
    end

    average_exchange_rates = @brl_exchange_rates - [@brl_exchange_rates.first, @brl_exchange_rates.last]

    unless average_exchange_rates.empty?
      @average_initial_date = average_exchange_rates.first.date.strftime('%d/%m/%Y')
      @average_final_date = average_exchange_rates.last.date.strftime('%d/%m/%Y')

      @average_rate = (average_exchange_rates.inject(0) { |sum, x| sum + x.value} / average_exchange_rates.size())
      @average_rate = @average_rate.round(4)
    end

  end

end
