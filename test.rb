require 'rubygems'
require 'json'
require 'factergrep'
#Replace with whatever data you want. The less shit you have to parse, the better
document = JSON.load(File.read("facts.json"))
search_item = "mac_address"
search_value = "0:c:29:6b:b7:cf"
result = Factgrep.new(document, search_item, search_value)
result.display_simplified
pp result.find_value
