require 'rubygems'
require 'json'

json =ARGV[0]
parsed_json = JSON.parse(json)
return parsed_json["public_url"]

