class BrlExchangeRatesController < ApplicationController

  def index
    @brl_exchange_rates = BrlExchangeRate.all
  end

  def process_json
    puts "Working"
    redirect_to brl_exchange_rates_path
  end

end
