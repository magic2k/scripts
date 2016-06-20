require 'rubygems'
require 'couchrest'
#require 'date'

server = CouchRest.new
#create db if it doesn't already exist
db = server.database!('test_db')

begin
  doc = db.get('doc')
rescue RestClient::ResourceNotFound => nfe
  #Save document, with id
  puts nfe
  db.save_doc('_id' => 'doc', 'name' => 'test', 'date' => DateTime.now)
  doc = db.get('doc')
end


puts doc.inspect
#1db.delete_doc(doc)


