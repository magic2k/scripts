#First cli parameter is the field in document to search for
#

require 'rubygems'
require 'couchrest'

key = ARGV[0]
errored_dbs = 0

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
# db.get(doc_id)
end

def substitute_unsafe_chars(string)
  string.gsub!('/','%2F')
  string.gsub!('-','%2D')
#  string.gsub!('.','%2E')
#  string.gsub!('_','%5F')
end

dbs = get_all_dbs

dbs.each do |db|
  substitute_unsafe_chars(db)
#  puts '----' + db + '----'
  begin
    docs = get_db_docs(db)
#    puts "\nDB have documents: " + docs["total_rows"].to_s
  rescue
    puts 'Can\'t open ' + db
    errored_dbs=+1
    next
  end
  doc_ids = get_doc_ids docs

  docs_with_field = []
  doc_ids.each do |id|
    substitute_unsafe_chars id
    doc = get_document db, id
    if doc.has_key?(key)
      docs_with_field << id
    end
  end
  unless docs_with_field.empty?
    puts "\nDocuments and db that contains \'" + key + "\' field: "
    puts docs_with_field.to_s
    puts "\n-------end of " + db + " ------------\n\n\n\n"
  end
end

puts 'errored dbs: ' + errored_dbs.to_s

