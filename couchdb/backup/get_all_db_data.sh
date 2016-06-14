#!/bin/bash
base_dir=dbs
string=$(curl -X GET http://localhost:5984/_all_dbs | sed 's/\[//' | sed 's/\]//' | sed 's/\"//g' | sed 's/\//%2F/g')

IFS=', ' read -a array <<< "$string"

mkdir ./$base_dir

for database in "${array[@]}"
do
#   db_filename=$(echo "$database" | sed 's/\//_/g')
  ./couchdb-backup.sh -b -H 127.0.0.1:5984 -f ./$base_dir/$database -d $database
done

