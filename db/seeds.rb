path = 'app/assets/algorithms/currencies.json'
file = File.open(path).read
exchange_rates = JSON.parse(file)

exchange_rates.each do |exchange_rate|
  date = exchange_rate['date']
  value = exchange_rate['value']
  puts "#{date} and #{value}"

  BrlExchangeRate.where(date: date, value: value).first_or_create
end
