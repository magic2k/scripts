require 'rubygems'
require 'couchrest'

key = "node"
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
end

dbs = get_all_dbs

dbs.each do |db|
  puts '----' + db + '----'
  begin
    docs = get_db_docs(db)
#    puts "\nDB have documents: " + docs["total_rows"].to_s
  rescue
#    puts 'Can\'t open ' + db
#    errored_dbs++
    next
  end
  doc_ids = get_doc_ids docs

  docs_with_field = []
  doc_ids.each do |id|
    doc = get_document db, id
    if doc.has_key?(key)
      docs_with_field << id
    end
  end

  puts "\nDocuments and db that contains \'"+ key +"\' field: "
  puts docs_with_field.to_s

  puts "\n-------end of "+ db +" ------------\n\n\n\n"
end


