require 'json'
require 'typhoeus'
require 'date'

initial_date = Date.new(2009, 8, 7)
final_date = Date.new(2011, 11, 17)

hydra = Typhoeus::Hydra.new(max_concurrency: 1)

i = 0
queries = (initial_date .. final_date).map { |date|

	url = "http://api.fixer.io/#{date}?base=USD&symbols=BRL"
	request = Typhoeus::Request.new(url, followlocation: true)

	hydra.queue(request)

	{date: date, request: request}
}

hydra.run

map = queries.map{ |query|
	current_date = query[:date]

	response_array = JSON.parse(query[:request].response.body)
	value = response_array['rates']['BRL']

	{date: current_date, value: value}
}

File.open('currencies.json', 'w') do |file|
	currency_json = JSON.pretty_generate(map, {indent: "\t", object_nl: "\n"})
	file.write(currency_json)
end
