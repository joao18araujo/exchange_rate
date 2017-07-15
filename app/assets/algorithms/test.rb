require 'json'
require 'date'

file = File.read('currencies.json')
exchange_rates = JSON.parse(file)


puts exchange_rates.minmax_by { |x| x['value'] }

exchange_rates_2 = exchange_rates - [exchange_rates.first, exchange_rates.last]
average_rate = exchange_rates_2.inject(0) { |sum, x| sum + x['value']} / exchange_rates_2.size()

puts average_rate
