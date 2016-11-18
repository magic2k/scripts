require 'rubygems'
require 'json'

def parseSimpleJson json
  #json =ARGV[0]
  parsed_json = JSON.parse(json)
  return parsed_json["public_url"]
end

def getNestedHashFromJsonElement json
  parsed_json = JSON.parse(json)
  results_hash = parsed_json['someElement'][0]
  return results_hash
end
