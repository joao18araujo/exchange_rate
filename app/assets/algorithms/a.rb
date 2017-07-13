require 'json'

file = File.read('currencies.json')

s = JSON.parse(file)

puts s
