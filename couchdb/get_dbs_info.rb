require 'rubygems'
require 'couchrest'
#require 'json'

SERVER = CouchRest.new

def get_all_dbs
  CouchRest.get("http://localhost:5984/_all_dbs")
end

def get_db_docs(db)
   CouchRest.get("http://localhost:5984/#{db}/_all_docs")
end

def get_doc_ids(docs_hash)
  doc_ids = []
  docs_hash["rows"].each do |row|
    doc_ids << row["id"]
  end
  doc_ids
end

def get_document(db, doc_id)
  CouchRest.get("http://localhost:5984/#{db}/#{doc_id}")
end

dbs = get_all_dbs

dbs.each do |db|
  puts '----' + db + '----'
  docs = get_db_docs(db)
  puts "\nDB have documents: " + docs["total_rows"].to_s
#  puts docs
#  puts JSON.parse(doc.to_s)
  puts "\nDocuments ids:"
  doc_ids = get_doc_ids docs
  puts doc_ids
  puts "\nFirst document content: "
  document = get_document db, doc_ids.first
  puts document

  puts "\nDocument contains 'node' field: " + document.has_key?("node").to_s

  puts "\n-------end of '+db+'------------\n\n\n\n"
end


