require 'rubygems'
require 'curb'
require 'json'
require 'pp'

auth_token = ARGV[0]
acc_ids = []
url_ids = []
url_docs = []
#get all descendants
c = Curl::Easy.perform("http://127.0.0.1:8000/v1/accounts/fb0f60ef1bf690ab0f767d2ed3b5e27b/descendants") do |http|
  http.headers['X-Auth-Token'] = auth_token
  http.headers['Accept'] = 'application/json'
  http.headers['Content_type'] = 'application/json'
end

c.perform
desc_data = JSON.parse(c.body_str)
#pp desc_data
desc_data['data'].each do |item_hash|
  acc_ids << item_hash['id']
end

#puts acc_ids

#convert each id to URL string
acc_ids.each do |acc|
  #getting request string before acc string modification
  req = "http://127.0.0.1:8000/v1/accounts/" + acc +"/users"

  url_string = acc.insert(2, '%2F')
  url_string = url_string.insert(7, '%2F')
  url_ids << 'http://127.0.0.1:5984/_utils/database.html?account%2F' + url_string

  #acquiring user doc
  d = Curl::Easy.perform(req) do |http|
     http.headers['X-Auth-Token'] = auth_token
     http.headers['Accept'] = 'application/json'
     http.headers['Content_type'] = 'application/json'
  end
  d.perform
  doc_data = JSON.parse(d.body_str)

  # acquiring user ids
  doc_data['data'].each do |usr_hash|
#   usr_ids << usr_hash['id']
    url_docs << 'http://127.0.0.1:5984/_utils/document.html?account%2F' + url_string + '/' + usr_hash['id']
  end
  puts url_docs
end
puts 'list size is: ' + url_docs.length.to_s


